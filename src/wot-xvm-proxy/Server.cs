using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.AccessControl;
using System.Text;
using System.Threading;
using System.Xml;

using DokanNet;
using LitJson;
using wot.Properties;

namespace wot
{
    class Server : IDokanOperations
    {
        #region Private Members


        // local cache
        private readonly Dictionary<string, PlayerInfo> cache = new Dictionary<string, PlayerInfo>();

        private readonly Dictionary<string, Stat> pendingPlayers = new Dictionary<string, Stat>();

        private Info _modInfo = null;
        private bool _firstError = true;
        private bool _unavailable = false;
        private DateTime _unavailableFrom;
        private String _lastResult = "";
        private bool added = false;
        private Thread runningIngameThread;

        private XvmApi Api { get; set; } = null;

        private readonly object _lockIngame = new object();
        public String version { get; set; } = "CT";
        #endregion

        #region .ctor()

        public Server(XvmApi api)
        {
            Api = api;
            Log(2, string.Format("LogLevel: {1}{0}MountPoint: {2}{0}Timeout: {3}",
              Environment.NewLine,
              Settings.Default.LogLevel,
              Settings.Default.MountPoint,
              Settings.Default.Timeout));
        }

        #endregion

        #region service functions

        private static void Log(int level, string message)
        {
            if (level >= Settings.Default.LogLevel)
                Console.WriteLine(message);
        }

        private static void Debug(string message)
        {
            if (Program.isDebug)
                Console.WriteLine("DEBUG: " + message);
        }

        private bool ServiceUnavailable()
        {
            if (!_unavailable)
                return false;

            if (DateTime.Now.Subtract(_unavailableFrom).Minutes < Settings.Default.ServerUnavailableTimeout)
                return true;
            _unavailable = false;
            return false;
        }

        private void ErrorHandle()
        {
            if (_firstError)
            {
                _unavailable = true;
                _firstError = false;
                _unavailableFrom = DateTime.Now;
                Log(2, string.Format("Unavailable since {0}", _unavailableFrom));
            }
            else
            {
                _firstError = true;
                Log(2, string.Format("First error {0}", DateTime.Now));
            }
        }

        // name-id,name-id,... or name,name,...
        private void AddPendingPlayers(String parameters)
        {
            lock (_lockIngame)
            {
                String[] chunks = parameters.Split(',');
                foreach (String chunk in chunks)
                {
                    // The character "-" may be used in china server as the username, for example  "-_-" 
                    String[] param = new String[2];
                    param[0] = chunk.Substring(0, chunk.LastIndexOf("-")).Trim();
                    param[1] = chunk.Substring(chunk.LastIndexOf("-") + 1).Trim();

                    string name = param[0].ToUpper();
                    int id = (param.Length > 1) ? int.Parse(param[1]) : 0;
                    if (!pendingPlayers.ContainsKey(name))
                    {
                        pendingPlayers[name] = new Stat()
                        {
                            id = id,
                            name = name
                        };
                    }
                }
                added = true;
            }
        }

        private void SetPendingPlayers(String parameters)
        {
            lock (_lockIngame)
            {
                pendingPlayers.Clear();
                AddPendingPlayers(parameters);
            }
        }

        private string getPendingPlayersResult()
        {
            string result = "";
            foreach (Stat stat in pendingPlayers.Values)
            {
                if (result != "")
                    result += ",";
                result += String.Format("{0}-{1}", stat.name, stat.id);
            }
            return result;
        }

        private void retrieveStats()
        {
            lock (_lockIngame)
            {
                added = false;
                Log(1, "retrieveStats()");
                _prevResult = _lastResult = GetStat();
                Debug("_lastResult: " + _lastResult);
            }
        }

        #endregion

        #region IDokanOperations

        private string _prevCommand = null;
        private string _prevResult = null;
        private string _temp = null;

        private readonly object _lock = new object();

        public NtStatus CreateFile(string fileName, DokanNet.FileAccess access, FileShare share, FileMode mode, FileOptions options, FileAttributes attributes, DokanFileInfo info)
        {
            Log(0, $"-> CreateFile({fileName})");
            return NtStatus.Success;
        }

        public void Cleanup(string fileName, DokanFileInfo info)
        {
            Log(0, $"-> Cleanup({fileName})");
        }

        public void CloseFile(string fileName, DokanFileInfo info)
        {
            Log(0, String.Format("-> CloseFile({0})", fileName));
        }

        public NtStatus ReadFile(string fileName, byte[] buffer, out int bytesRead, long offset, DokanFileInfo info)
        {
            bytesRead = 0;

            lock (_lock)
            {
                if (string.Compare(fileName, "\\@RETRIEVE", true) == 0 &&
                  (string.IsNullOrEmpty(_prevResult) || _prevResult == "FINISHED"))
                {
                    _prevResult = _lastResult;
                    Debug("Retrieving");
                }
                if (!String.IsNullOrEmpty(_prevResult))
                {
                    using (MemoryStream ms = new MemoryStream(Encoding.ASCII.GetBytes(_prevResult)))
                    {
                        ms.Seek(offset, SeekOrigin.Begin);
                        bytesRead = ms.Read(buffer, 0, buffer.Length);
                        Log(1, $"Readed {bytesRead} bytes");
                    }
                }

                return NtStatus.Success;
            }
        }

        public NtStatus WriteFile(string fileName, byte[] buffer, out int bytesWritten, long offset, DokanFileInfo info)
        {
            bytesWritten = 0;
            Log(0, $"-> WriteFile({fileName})");
            return NtStatus.NotImplemented;
        }

        public NtStatus FlushFileBuffers(string fileName, DokanFileInfo info)
        {
            Log(0, String.Format("-> FlushFileBuffers({0})", fileName));
            return NtStatus.NotImplemented;
        }

        public NtStatus GetFileInformation(string fileName, out FileInformation fileInfo, DokanFileInfo info)
        {
            lock (_lock)
            {
                fileInfo = new FileInformation();

                try
                {
                    // XP send filename in lowercase, W7 in uppercase. Make them both the same.
                    fileName = fileName.ToUpper();

                    fileInfo.Attributes = FileAttributes.Archive;
                    fileInfo.CreationTime = DateTime.Now;
                    fileInfo.LastAccessTime = DateTime.Now;
                    fileInfo.LastWriteTime = DateTime.Now;
                    fileInfo.Length = 0;

                    if (fileName == _prevCommand)
                    {
                        if (!string.IsNullOrEmpty(_prevResult))
                        {
                            fileInfo.Length = _prevResult.Length;
                        }
                        return NtStatus.Success;
                    }

                    _prevCommand = fileName;
                    _prevResult = _prevResult == "FINISHED" ? _temp : "";

                    if (!fileName.StartsWith("\\@LOG"))
                        Log(1, $"=> GetFileInformation({fileName})");
                    var command = Path.GetFileName(fileName);
                    if (string.IsNullOrEmpty(command) || command[0] != '@')
                        return 0;

                    var parameters = "";
                    if (command.Contains(" "))
                    {
                        string[] cmd = command.Split(new char[] { ' ' }, 2);
                        command = cmd[0];
                        parameters = cmd[1];
                    }

                    Thread t;
                    switch (command)
                    {
                        case "@LOG":
                            Log(1, parameters);
                            break;

                        case "@SET":
                            t = new Thread(() => SetPendingPlayers(parameters));
                            t.Start();
                            break;

                        case "@ADD":
                            t = new Thread(() => AddPendingPlayers(parameters));
                            t.Start();
                            break;

                        case "@RUN":
                            _lastResult = GetStat(); // this will start network operations
                            Debug("_lastResult: " + _lastResult);
                            _prevResult = _lastResult;
                            break;

                        case "@RUNINGAME":
                            if (added)
                            {
                                runningIngameThread = new Thread(() => retrieveStats());
                                runningIngameThread.Start(); // this too
                            }
                            break;

                        case "@RETRIEVE":
                            Debug("_prevResult: " + _prevResult);
                            Debug("_lastResult: " + _lastResult);
                            break;

                        case "@READY":
                            if (runningIngameThread != null && !runningIngameThread.IsAlive)
                            {
                                _temp = _prevResult;
                                _prevResult = "FINISHED";
                            }
                            break;

                        case "@GET_LAST_STAT":
                            _prevResult = _lastResult;
                            break;

                        case "@GET":
                            _prevResult = getPendingPlayersResult();
                            break;

                        default:
                            Log(2, "Unknown command: " + fileName);
                            break;
                    }

                    _firstError = false;

                    if (_prevResult == null)
                        _prevResult = "";

                    fileInfo.Length = _prevResult.Length;
                }
                catch (Exception ex)
                {
                    Log(2, "Exception: " + ex);
                }

                return NtStatus.Success;
            }
        }

        public NtStatus FindFiles(string fileName, out IList<FileInformation> files, DokanFileInfo info)
        {
            files = new List<FileInformation>();
            Log(0, String.Format("-> FindFiles({0})", fileName));
            return NtStatus.Success;
        }

        public NtStatus FindFilesWithPattern(string fileName, string searchPattern, out IList<FileInformation> files, DokanFileInfo info)
        {
            files = new List<FileInformation>();
            Log(0, String.Format("-> FindFilesWithPattern({0},{1})", fileName, searchPattern));
            return NtStatus.Success;
        }

        public NtStatus SetFileAttributes(string fileName, FileAttributes attributes, DokanFileInfo info)
        {
            Log(0, String.Format("-> SetFileAttributes({0})", fileName));
            return NtStatus.NotImplemented;
        }

        public NtStatus SetFileTime(string fileName, DateTime? creationTime, DateTime? lastAccessTime, DateTime? lastWriteTime, DokanFileInfo info)
        {
            Log(0, String.Format("-> SetFileTime({0})", fileName));
            return NtStatus.NotImplemented;
        }

        public NtStatus DeleteFile(string fileName, DokanFileInfo info)
        {
            Log(0, String.Format("-> DeleteFile({0})", fileName));
            return NtStatus.NotImplemented;
        }

        public NtStatus DeleteDirectory(string fileName, DokanFileInfo info)
        {
            Log(0, String.Format("-> DeleteDirectory({0})", fileName));
            return NtStatus.NotImplemented;
        }

        public NtStatus MoveFile(string oldName, string newName, bool replace, DokanFileInfo info)
        {
            Log(0, String.Format("-> MoveFile({0}, {1})", oldName, newName));
            return NtStatus.NotImplemented;
        }

        public NtStatus SetEndOfFile(string fileName, long length, DokanFileInfo info)
        {
            Log(0, String.Format("-> SetEndOfFile({0})", fileName));
            return NtStatus.NotImplemented;
        }

        public NtStatus SetAllocationSize(string fileName, long length, DokanFileInfo info)
        {
            Log(0, String.Format("-> SetAllocationSize({0})", fileName));
            return NtStatus.Success;
        }

        public NtStatus LockFile(string fileName, long offset, long length, DokanFileInfo info)
        {
            Log(0, String.Format("-> LockFile({0})", fileName));
            return NtStatus.Success;
        }

        public NtStatus UnlockFile(string fileName, long offset, long length, DokanFileInfo info)
        {
            Log(0, String.Format("-> UnlockFile({0})", fileName));
            return NtStatus.Success;
        }

        public NtStatus GetDiskFreeSpace(out long freeBytesAvailable, out long totalNumberOfBytes, out long totalNumberOfFreeBytes, DokanFileInfo info)
        {
            Log(0, "-> GetDiskFreeSpace()");
            freeBytesAvailable = 512 * 1024 * 1024;
            totalNumberOfBytes = 1024 * 1024 * 1024;
            totalNumberOfFreeBytes = 512 * 1024 * 1024;
            return NtStatus.Success;
        }

        public NtStatus GetVolumeInformation(out string volumeLabel, out FileSystemFeatures features, out string fileSystemName, out uint maximumComponentLength, DokanFileInfo info)
        {
            volumeLabel = "XVM";
            features = FileSystemFeatures.None;
            fileSystemName = "XVMFS";
            maximumComponentLength = 65535;
            return NtStatus.Success;
        }

        public NtStatus GetFileSecurity(string fileName, out FileSystemSecurity security, AccessControlSections sections, DokanFileInfo info)
        {
            security = null;
            return NtStatus.NotImplemented;
        }

        public NtStatus SetFileSecurity(string fileName, FileSystemSecurity security, AccessControlSections sections, DokanFileInfo info)
        {
            return NtStatus.NotImplemented;
        }

        public NtStatus Mounted(DokanFileInfo info)
        {
            Log(0, "-> Mount()");
            return NtStatus.Success;
        }

        public NtStatus Unmounted(DokanFileInfo info)
        {
            Log(0, "-> Unmount()");
            return NtStatus.Success;
        }

        public NtStatus FindStreams(string fileName, out IList<FileInformation> streams, DokanFileInfo info)
        {
            streams = null;
            return NtStatus.NotImplemented;
        }

        #endregion

        #region Network operations

        private string GetStat()
        {
            PrepareStat();

            Response res = new Response()
            {
                players = new List<Stat>(),
                info = _modInfo,
            };

            foreach (var name in pendingPlayers.Keys)
            {
                string uname = name.ToUpper();
                if (cache.ContainsKey(uname))
                {
                    res.players.Add(cache[uname].stat);
                }
            }

            return JsonMapper.ToJson(res);
        }


        private string stripRegion(string name)
        {
            //Check for region suffix
            var parts = name.Split('_');
            if (parts.Length == 1)
            {
                return name;
            }

            var reg = parts[parts.Length - 1];
            if (reg == "NA" || reg == "EU" || reg == "RU" || reg == "ASIA" || reg == "CN")
            {
                name = String.Join("_", parts, 0, parts.Length - 1).ToUpper();
            }

            return name;
        }

        private void PrepareStat()
        {
            Dictionary<long, string> forUpdate = new Dictionary<long, string>();
            
            foreach (string name in pendingPlayers.Keys)
            {
                string uname = name.ToUpper();
                if (cache.ContainsKey(uname))
                {
                    PlayerInfo currentMember = cache[uname];

                    if (!currentMember.httpError)
                    {
                        Log(1, string.Format("CACHE - {0}: eff={1} battles={2} wins={3}", name,
                          currentMember.stat.eff, currentMember.stat.battles, currentMember.stat.wins));
                        continue;
                    }

                    if (DateTime.Now.Subtract(currentMember.errorTime).Minutes < Settings.Default.ServerUnavailableTimeout)
                    {
                        continue;
                    }

                    cache.Remove(uname);
                }

                forUpdate.Add(pendingPlayers[uname].id, uname);
            }

            if (forUpdate.Count == 0 || ServiceUnavailable())
            {
                return;
            }

            try
            {
                var resp = Api.GetStatsAsync(forUpdate.Keys);

                foreach (Stat stat in resp.Result)
                {
                    //fixup name
                    stat.name = forUpdate[stat.id];

                    if (string.IsNullOrEmpty(stat.name))
                    {
                        continue;
                    }

                    cache[stat.name.ToUpper()] = new PlayerInfo()
                    {
                        stat = stat,
                        httpError = false
                    };
                };

                _modInfo = new Info
                {
                    xvm = new XVMInfo
                    {
                        message = "Ne, ne lychshe",
                        ver = "1.9"
                    }
                };
            }
            catch (Exception ex)
            {
                Log(2, string.Format("Exception: {0}", ex));
                ErrorHandle();
                foreach(var kvp in forUpdate)
                {
                    string name = kvp.Value;
                    cache[name.ToUpper()] = new PlayerInfo()
                    {
                        stat = new Stat()
                        {
                            name = name
                        },
                        httpError = true,
                        errorTime = DateTime.Now
                    };
                }
            }
        }

        #endregion

    }
}
