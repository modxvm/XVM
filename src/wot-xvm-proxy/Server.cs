using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using Dokan;
using LitJson;
using wot.Properties;
using System.Diagnostics;

namespace wot
{
  class Server : DokanOperations
  {
    #region Private Members

    [Serializable]
    public class Stat
    {
      public int id;
      public String name;
      public int eff;
      public int battles;
      public int wins;
    }

    [Serializable]
    public class XVMInfo
    {
      public String ver;
      public String message;
    }

    [Serializable]
    public class Info
    {
      public XVMInfo xvm;
    }

    [Serializable]
    public class Response
    {
      public Stat[] players;
      public Info info;
    }

    [Serializable]
    public class PlayerInfo
    {
      public Stat stat;
      [NonSerialized]
      public bool httpError;
      [NonSerialized]
      public DateTime errorTime;
    }

    // local cache
    private readonly Dictionary<string, PlayerInfo> cache = new Dictionary<string, PlayerInfo>();

    private readonly Dictionary<string, Stat> pendingPlayers = new Dictionary<string, Stat>();

    private Info _modInfo = null;
    private bool _firstError = true;
    private bool _unavailable = false;
    private DateTime _unavailableFrom;
    private String _lastResult = "";

    #endregion

    #region .ctor()

    public Server()
    {
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
      String[] chunks = parameters.Split(',');
      foreach (String chunk in chunks)
      {
        String[] param = chunk.Split('-');
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
    #endregion

    #region Dokan default implementations

    public int CreateFile(String filename, FileAccess access, FileShare share,
                          FileMode mode, FileOptions options, DokanFileInfo info)
    {
      Log(0, String.Format("-> CreateFile({0})", filename));
      return 0;
    }

    public int OpenDirectory(String filename, DokanFileInfo info)
    {
      Log(0, String.Format("-> OpenDirectory({0})", filename));
      return 0;
    }

    public int CreateDirectory(String filename, DokanFileInfo info)
    {
      Log(0, String.Format("-> CreateDirectory({0})", filename));
      return -1;
    }

    public int Cleanup(String filename, DokanFileInfo info)
    {
      Log(0, String.Format("-> Cleanup({0})", filename));
      return 0;
    }

    public int WriteFile(String filename, Byte[] buffer,
                         ref uint writtenBytes, long offset, DokanFileInfo info)
    {
      Log(0, String.Format("-> WriteFile({0})", filename));
      return -1;
    }

    public int FlushFileBuffers(String filename, DokanFileInfo info)
    {
      Log(0, String.Format("-> FlushFileBuffers({0})", filename));
      return -1;
    }

    public int CloseFile(String filename, DokanFileInfo info)
    {
      Log(0, String.Format("-> CloseFile({0})", filename));
      return 0;
    }

    public int FindFiles(String filename, ArrayList files, DokanFileInfo info)
    {
      Log(0, String.Format("-> FindFiles({0})", filename));
      return 0;
    }

    public int SetFileAttributes(String filename, FileAttributes attr, DokanFileInfo info)
    {
      Log(0, String.Format("-> SetFileAttributes({0})", filename));
      return -1;
    }

    public int SetFileTime(String filename, DateTime ctime,
                           DateTime atime, DateTime mtime, DokanFileInfo info)
    {
      Log(0, String.Format("-> SetFileTime({0})", filename));
      return -1;
    }

    public int DeleteFile(String filename, DokanFileInfo info)
    {
      Log(0, String.Format("-> DeleteFile({0})", filename));
      return -1;
    }

    public int DeleteDirectory(String filename, DokanFileInfo info)
    {
      Log(0, String.Format("-> DeleteDirectory({0})", filename));
      return -1;
    }

    public int MoveFile(String filename, String newname, bool replace, DokanFileInfo info)
    {
      Log(0, String.Format("-> MoveFile({0})", filename));
      return -1;
    }

    public int SetEndOfFile(String filename, long length, DokanFileInfo info)
    {
      Log(0, String.Format("-> SetEndOfFile({0})", filename));
      return -1;
    }

    public int SetAllocationSize(String filename, long length, DokanFileInfo info)
    {
      Log(0, String.Format("-> SetAllocationSize({0})", filename));
      return -1;
    }

    public int LockFile(String filename, long offset, long length, DokanFileInfo info)
    {
      Log(0, String.Format("-> LockFile({0})", filename));
      return 0;
    }

    public int UnlockFile(String filename, long offset, long length, DokanFileInfo info)
    {
      Log(0, String.Format("-> UnlockFile({0})", filename));
      return 0;
    }

    public int GetDiskFreeSpace(ref ulong freeBytesAvailable, ref ulong totalBytes,
                                ref ulong totalFreeBytes, DokanFileInfo info)
    {
      Log(0, "-> GetDiskFreeSpace()");
      freeBytesAvailable = 512 * 1024 * 1024;
      totalBytes = 1024 * 1024 * 1024;
      totalFreeBytes = 512 * 1024 * 1024;
      return 0;
    }

    public int Unmount(DokanFileInfo info)
    {
      Log(0, "-> Unmount()");
      return 0;
    }

    #endregion

    #region Dokan overrides

    private string _prevCommand = null;
    private string _prevResult = null;

    private readonly object _lock = new object();

    public int GetFileInformation(String filename, FileInformation fileinfo, DokanFileInfo info)
    {
      lock (_lock)
      {
        try
        {
          fileinfo.Attributes = FileAttributes.Archive;
          fileinfo.CreationTime = DateTime.Now;
          fileinfo.LastAccessTime = DateTime.Now;
          fileinfo.LastWriteTime = DateTime.Now;
          fileinfo.Length = 0;

          if (filename == _prevCommand)
          {
            if (!String.IsNullOrEmpty(_prevResult))
              fileinfo.Length = _prevResult.Length;
            return 0;
          }

          _prevCommand = filename;
          _prevResult = "";

          if (!filename.StartsWith("\\@LOG"))
            Log(1, String.Format("=> GetFileInformation({0})", filename));
          String command = Path.GetFileName(filename).ToUpper();
          if (String.IsNullOrEmpty(command) || command[0] != '@')
            return 0;

          String parameters = "";
          if (command.Contains(" "))
          {
            string[] cmd = command.Split(new char[] { ' ' }, 2);
            command = cmd[0];
            parameters = cmd[1];
          }

          switch (command)
          {
            case "@LOG":
              Log(1, parameters);
              break;

            case "@SET":
              pendingPlayers.Clear();
              AddPendingPlayers(parameters);
              break;

            case "@ADD":
              AddPendingPlayers(parameters);
              break;

            case "@RUN":
              _lastResult = GetStat(); // only this will start network operations
              Debug("_lastResult: " + _lastResult);
              _prevResult = _lastResult;
              break;

            case "@GET_LAST_STAT":
              _prevResult = _lastResult;
              break;

            case "@GET":
              _prevResult = getPendingPlayersResult();
              break;

            default:
              Log(2, "Unknown command: " + filename);
              break;
          }

          _firstError = false;

          if (_prevResult == null)
            _prevResult = "";
            
          fileinfo.Length = _prevResult.Length;
        }
        catch (Exception ex)
        {
          Log(2, "Exception: " + ex);
        }

        return 0;
      }
    }

    public int ReadFile(String filename, Byte[] buffer, ref uint readBytes, long offset, DokanFileInfo info)
    {
      lock (_lock)
      {
        if (!String.IsNullOrEmpty(_prevResult))
        {
          using (MemoryStream ms = new MemoryStream(Encoding.ASCII.GetBytes(_prevResult)))
          {
            ms.Seek(offset, SeekOrigin.Begin);
            readBytes = (uint)ms.Read(buffer, 0, buffer.Length);
            Log(1, String.Format("Readed {0} bytes", readBytes));
          }
        }
        return 0;
      }
    }
    #endregion

    #region Network operations

    private string GetStat()
    {
      PrepareStat();

      Response res = new Response()
      {
        players = new Stat[pendingPlayers.Keys.Count],
        info = _modInfo,
      };

      int pos = 0;
      foreach (string name in pendingPlayers.Keys)
      {
        string uname = name.ToUpper();
        if (cache.ContainsKey(uname))
          res.players[pos++] = cache[uname].stat;
      }
      Array.Resize<Stat>(ref res.players, pos);

      return JsonMapper.ToJson(res);
    }

    private void PrepareStat()
    {
      List<string> forUpdate = new List<string>();
      List<string> forUpdateNames = new List<string>();

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
            continue;
          cache.Remove(uname);
        }

        forUpdate.Add(pendingPlayers[uname].id.ToString());
        forUpdateNames.Add(uname);
      }

      if (forUpdate.Count == 0 || ServiceUnavailable())
        return;

      try
      {
        String reqMembers = String.Join(",", forUpdate.ToArray());
        // Load balancer
        string proxy_addr = Settings.Default.proxy_servers[
          (new Random()).Next(Settings.Default.proxy_servers.Count)];
        byte[] decbuff = Convert.FromBase64String(proxy_addr);
        String url = Encoding.ASCII.GetString(decbuff).Replace("%1", reqMembers);

        Log(1, String.Format("HTTP - {0}", reqMembers));

        Stopwatch sw = new Stopwatch();
        sw.Start();

        WebRequest request = WebRequest.Create(url);
        request.Credentials = CredentialCache.DefaultCredentials;
        request.Timeout = Settings.Default.Timeout;

        HttpWebResponse response = (HttpWebResponse)request.GetResponse();

        Stream dataStream = response.GetResponseStream();
        StreamReader reader = new StreamReader(dataStream);
        string responseFromServer = reader.ReadToEnd();

        reader.Close();
        dataStream.Close();
        response.Close();

        sw.Stop();

        Log(1, String.Format("  Time: {0} ms, Size: {1} bytes",
          sw.ElapsedMilliseconds, responseFromServer.Length));

        Debug("responseFromServer: " + responseFromServer);

        Response res = JsonDataToResponse(JsonMapper.ToObject(responseFromServer));
        if (res == null || res.players == null)
        {
          Log(2, "WARNING: empty response or parsing error");
          return;
        }
        foreach (Stat stat in res.players)
        {
          if (String.IsNullOrEmpty(stat.name))
            continue;
          cache[stat.name.ToUpper()] = new PlayerInfo()
          {
            stat = stat,
            httpError = false
          };
        };
        _modInfo = res.info;
      }
      catch (Exception ex)
      {
        Log(2, string.Format("Exception: {0}", ex));
        ErrorHandle();
        for (var i = 0; i < forUpdate.Count; i++)
        {
          string name = forUpdateNames[i];
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

    private static Response JsonDataToResponse(JsonData jd)
    {
      if (jd == null)
        return null;

      Response res = new Response();

      try
      {
        if (jd["players"] != null && jd["players"].IsArray)
        {
          res.players = new Stat[jd["players"].Count];
          int pos = 0;
          foreach (JsonData data in jd["players"])
          {
            res.players[pos++] = new Stat()
            {
              id = data["id"].IsInt ? int.Parse(data["id"].ToString()) : 0,
              name = data["name"].ToString(),
              eff = data["eff"].IsInt ? int.Parse(data["eff"].ToString()) : 0,
              battles = data["battles"].IsInt ? int.Parse(data["battles"].ToString()) : 0,
              wins = data["wins"].IsInt ? int.Parse(data["wins"].ToString()) : 0,
            };
          }
        }
      }
      catch (Exception ex)
      {
        Log(2, "Parse error: players: " + ex);
      }

      try
      {
        if (jd["info"] != null)
        {
          res.info = new Info();
          if (jd["info"]["xvm"] != null)
          {
            JsonData data = jd["info"]["xvm"];
            res.info.xvm = new XVMInfo()
            {
              ver = data["ver"].ToString(),
              message = data["message"].ToString(),
            };
          }
        }
      }
      catch (Exception ex)
      {
        Log(2, "Parse error: info: " + ex);
      }

      return res;
    }

    #endregion

  }
}
