using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Text;
using System.Threading;
using System.Xml;
using Dokan;
using LitJson;
using wot.Properties;
using System.Reflection;

namespace wot
{
  class Server : DokanOperations
  {
    #region Private Members

    [Serializable]
    public class Stat
    {
      public long id;         // player id
      public String name;     // player name
      public String clan;     // clan
      public String vn;       // vehicle name
      public int me;          // me
      public int b;           // total battles
      public int w;           // total wins
      public int e;           // global efficiency
      public int tb;          // tank battles
      public int tw;          // tank wins
      public int tl;          // tank level
      public int ts;          // tank spotted
      public int td;          // tank damage
      public int tf;          // tank frags
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
      public bool notInDb = false;
      [NonSerialized]
      public DateTime errorTime;
    }

    // local cache
    private readonly Dictionary<string, PlayerInfo> cache = new Dictionary<string, PlayerInfo>();
    private readonly Dictionary<long, Stat> pendingPlayers = new Dictionary<long, Stat>();

    private Info _modInfo = null;
    private bool _firstError = true;
    private bool _unavailable = false;
    private DateTime _unavailableFrom;
    private String _lastResult = "";
    private readonly String _currentProxyUrl;
    private Thread runningIngameThread = null;
    private bool resultReady = false;

    private readonly object _lockIngame = new object();
    public String version;
    #endregion

    #region .ctor()

    public Server(String ver)
    {
      Log(string.Format("Timeout: {0}, MountPoint: {1}", Settings.Default.Timeout, Settings.Default.MountPoint));

      //check version
      version = String.IsNullOrEmpty(ver) ? GetVersion() : ver;
      Log(string.Format("Game Region: {0}{1}", version, String.IsNullOrEmpty(ver) ? " (detected)" : ""));
      _currentProxyUrl = GetProxyAddress();
    }

    #endregion

    #region service functions

    private static void Log(string message)
    {
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
        Log(string.Format("Unavailable since {0}", _unavailableFrom));
      }
      else
      {
        _firstError = true;
        Log(string.Format("First error {0}", DateTime.Now));
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

    // id=name[clan]&vehicle,id=name&vehicle
    private void AddPendingPlayers(String parameters)
    {
      try
      {
        lock (_lockIngame)
        {
          String[] chunks = parameters.Split(',');
          foreach (String chunk in chunks)
          {
            String[] param = chunk.Split(new char[] { '=' }, 2, StringSplitOptions.RemoveEmptyEntries);
            if (param.Length != 2)
              continue;

            long id = long.Parse(param[0]);
            if (pendingPlayers.ContainsKey(id))
              continue;

            String[] param2 = param[1].Split(new char[] { '&' }, StringSplitOptions.RemoveEmptyEntries);

            string name = param2[0];
            string clan = "";
            if (name.Contains("["))
            {
              clan = name.Split(new char[] { '[', ']' }, 3)[1];
              name = name.Remove(name.IndexOf("["));
            }

            string vname = param2.Length > 1 ? param2[1] : "";
            int me;
            try
            {
              me = param2.Length > 2 ? int.Parse(param2[2]) : 0;
            }
            catch
            {
              me = 0;
            }

            pendingPlayers[id] = new Stat()
            {
              id = id,
              name = name,
              clan = clan,
              vn = vname,
              me = me,
            };
          }
        }
      }
      catch (Exception ex)
      {
        Log("Error: " + ex.ToString());
      }
    }

    /*private void retrieveStats()
    {
      lock (_lockIngame)
      {
        Log("retrieveStats()");
        _lastResult = GetStat();
        Debug("_lastResult: " + _lastResult);
      }
    } */

    private static string GetVersion()
    {
      string wotVersion = "RU";
      XmlNodeReader reader = null;
      try
      {
        string s = "";
        XmlDocument doc = new XmlDocument();
        //read WOTLauncher.cfg
        doc.Load("WOTLauncher.cfg");

        XmlNode xn = doc.SelectSingleNode("/info/patch_info_urls");

        XmlNodeList xnl = xn.ChildNodes;

        foreach (XmlNode xnf in xnl)
        {
          XmlElement xe = (XmlElement)xnf;
          s = xe.InnerText;
          if (s.LastIndexOf("http://update.wot.ru.wargaming.net") > -1 || s.LastIndexOf("http://update.worldoftanks.ru") > -1)
            wotVersion = "RU";
          else if (s.LastIndexOf("http://update.worldoftanks.com") > -1)
            wotVersion = "NA";
          else if (s.LastIndexOf("http://update.worldoftanks.eu") > -1)
            wotVersion = "EU";
          else if (s.LastIndexOf("http://update.worldoftanks.cn") > -1)
            wotVersion = "CN";
          else if (s.LastIndexOf("http://update.worldoftanks-sea.com") > -1)
            wotVersion = "SEA";
          else if (s.LastIndexOf("http://update.worldoftanks.vn") > -1)
            wotVersion = "VTC";
          else if (s.LastIndexOf("http://update-ct.worldoftanks.net") > -1)
            wotVersion = "CT";
        }
      }
      catch (Exception ex)
      {
        throw new Exception(String.Format("Cannot read WOTLauncher.cfg:{0}{1}",
            Environment.NewLine, ex));
      }
      finally
      {
        //clear
        if (reader != null)
          reader.Close();
      }

      return wotVersion;
    }

    #endregion

    #region Dokan default implementations

    public int CreateFile(String filename, FileAccess access, FileShare share,
      FileMode mode, FileOptions options, DokanFileInfo info)
    {
      return 0;
    }

    public int OpenDirectory(String filename, DokanFileInfo info)
    {
      return 0;
    }

    public int CreateDirectory(String filename, DokanFileInfo info)
    {
      return -1;
    }

    public int Cleanup(String filename, DokanFileInfo info)
    {
      return 0;
    }

    public int WriteFile(String filename, Byte[] buffer, ref uint writtenBytes, long offset, DokanFileInfo info)
    {
      return -1;
    }

    public int FlushFileBuffers(String filename, DokanFileInfo info)
    {
      return -1;
    }

    public int CloseFile(String filename, DokanFileInfo info)
    {
      return 0;
    }

    public int FindFiles(String filename, ArrayList files, DokanFileInfo info)
    {
      return 0;
    }

    public int SetFileAttributes(String filename, FileAttributes attr, DokanFileInfo info)
    {
      return -1;
    }

    public int SetFileTime(String filename, DateTime ctime, DateTime atime, DateTime mtime, DokanFileInfo info)
    {
      return -1;
    }

    public int DeleteFile(String filename, DokanFileInfo info)
    {
      return -1;
    }

    public int DeleteDirectory(String filename, DokanFileInfo info)
    {
      return -1;
    }

    public int MoveFile(String filename, String newname, bool replace, DokanFileInfo info)
    {
      return -1;
    }

    public int SetEndOfFile(String filename, long length, DokanFileInfo info)
    {
      return -1;
    }

    public int SetAllocationSize(String filename, long length, DokanFileInfo info)
    {
      return -1;
    }

    public int LockFile(String filename, long offset, long length, DokanFileInfo info)
    {
      return 0;
    }

    public int UnlockFile(String filename, long offset, long length, DokanFileInfo info)
    {
      return 0;
    }

    public int GetDiskFreeSpace(ref ulong freeBytesAvailable, ref ulong totalBytes, ref ulong totalFreeBytes, DokanFileInfo info)
    {
      freeBytesAvailable = 512 * 1024 * 1024;
      totalBytes = 1024 * 1024 * 1024;
      totalFreeBytes = 512 * 1024 * 1024;
      return 0;
    }

    public int Unmount(DokanFileInfo info)
    {
      return 0;
    }

    #endregion

    #region Dokan overrides

    private string _command = null;
    private string _result = null;

    private readonly object _lock = new object();

    public int GetFileInformation(String filename, FileInformation fileinfo, DokanFileInfo info)
    {
      lock (_lock)
      {
        try
        {
          // XP send filename in lowercase, W7 in uppercase. Make them both the same.
          filename = filename.ToUpper();

          fileinfo.Attributes = FileAttributes.Archive;
          fileinfo.CreationTime = DateTime.Now;
          fileinfo.LastAccessTime = DateTime.Now;
          fileinfo.LastWriteTime = DateTime.Now;
          fileinfo.Length = 0;

          if (filename == _command)
          {
            if (!String.IsNullOrEmpty(_result))
              fileinfo.Length = _result.Length;
            return 0;
          }
          _command = filename;
          _result = "";

          String command = Path.GetFileName(filename);
          if (String.IsNullOrEmpty(command) || command[0] != '@')
            return 0;

          if (!command.StartsWith("@LOG"))
            Log(String.Format("=> {0}", command));

          String parameters = "";
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
              ProcessLog(parameters);
              break;

            case "@SET":
              (new Thread(() => SetPendingPlayers(parameters))).Start();
              break;

            case "@ADD":
              (new Thread(() => AddPendingPlayers(parameters))).Start();
              break;

            case "@RUN":
              _lastResult = GetStat(); // this will start network operations
              Debug("_lastResult: " + _lastResult);
              _result = _lastResult;
              break;

            case "@RUNINGAME":
              if (resultReady)
                _result = _lastResult;
              else
              {
                if (runningIngameThread == null)
                {
                  runningIngameThread = new Thread(() =>
                  {
                    lock (_lockIngame)
                    {
                      _lastResult = GetStat();
                      resultReady = true;
                    }
                  });
                }
                if (!runningIngameThread.IsAlive)
                  runningIngameThread.Start(); // this too
                _result = "NOT_READY";
              }
              resultReady = false;
              break;

            case "@GET_LAST_STAT":
              _result = _lastResult;
              break;

            case "@GET_VERSION":
              _result = version + "\n" + Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
              break;

            default:
              Log("Unknown command: " + filename);
              break;
          }

          _firstError = false;

          if (_result == null)
            _result = "";

          fileinfo.Length = _result.Length;
        }
        catch (Exception ex)
        {
          Log("Exception: " + ex);
        }

        return 0;
      }
    }

    private string _lastReadFileFilenameAndOffset = "";
    public int ReadFile(String filename, Byte[] buffer, ref uint readBytes, long offset, DokanFileInfo info)
    {
      lock (_lock)
      {
        if (String.Compare(filename, "\\@RETRIEVE", true) == 0 &&
          (String.IsNullOrEmpty(_result) || _result == "FINISHED"))
        {
          _result = _lastResult;
          Debug("Retrieving");
        }
        if (!String.IsNullOrEmpty(_result))
        {
          using (MemoryStream ms = new MemoryStream(Encoding.ASCII.GetBytes(_result)))
          {
            ms.Seek(offset, SeekOrigin.Begin);
            readBytes = (uint)ms.Read(buffer, 0, buffer.Length);
          }

          if (filename + ":" + offset != _lastReadFileFilenameAndOffset)
          {
            _lastReadFileFilenameAndOffset = filename + ":" + offset; // Avoid double requests
            Log(String.Format("Read {0} bytes", readBytes));
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
      foreach (long id in pendingPlayers.Keys)
      {
        string cacheKey = id + "=" + pendingPlayers[id].vn;
        if (cache.ContainsKey(cacheKey))
        {
          res.players[pos] = cache[cacheKey].stat;
          // fix player names (for CT)
          res.players[pos].name = pendingPlayers[id].name;
          pos++;
        }
      }
      Array.Resize<Stat>(ref res.players, pos);

      return JsonMapper.ToJson(res);
    }

    // Get fastest proxy server (with minimal ping)
    private string GetProxyAddress()
    {
      List<string> ps = new List<string>();
      foreach (string server in Settings.Default.proxy_servers)
      {
        string[] s = server.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);

        if (s.Length >= 2 && String.Compare(s[0], version, true) == 0)
          ps.Add(s[1]);

        // Added support for Common Test - currently only RU server for easiness
        if (s.Length >= 2 && version == "CT" && String.Compare(s[0], "RU", true) == 0)
          ps.Add(s[1]);
      }

      if (ps.Count == 0)
        throw new Exception(String.Format("Cannot find proxy server for '{0}' in config", version));

      return GetFastestProxyAddress(ps);
    }

    private string GetFastestProxyAddress(List<string> ps)
    {
      long minTime = long.MaxValue;
      List<string> proxyUrl = new List<string>();
      Dictionary<string, long> proxyUrls = new Dictionary<string, long>();

      foreach (var addr in ps)
      {
        string tempUrl = Encoding.ASCII.GetString(Convert.FromBase64String(addr));

        long tmpTime = long.MaxValue;
        try
        {
          string testId = (version.StartsWith("CN", StringComparison.InvariantCultureIgnoreCase)) ? "test" : "001";
          loadUrl(tempUrl, testId, out tmpTime, true);
        }
        catch (Exception ex)
        {
          Log(string.Format("Exception: {0}", ex));
        }

        proxyUrls.Add(tempUrl, tmpTime);

        //Get the fastest load time
        if (tmpTime < minTime)
          minTime = tmpTime;
      }

      foreach (var urlload in proxyUrls)
      {
        //If little difference between the urls, add it for random select
        if ((urlload.Value - minTime) < 500)
          proxyUrl.Add(urlload.Key);
      }

      return proxyUrl[(new Random()).Next(proxyUrl.Count)];
    }

    private static string loadUrl(string url, string members)
    {
      long dummy;
      return loadUrl(url, members, out dummy);
    }

    private static string loadUrl(string url, string members, out long duration, bool test = false)
    {
      if (!test)
        Log("HTTP: " + members);
      url = url.Replace("%1", members);
      duration = long.MaxValue;

      Stopwatch sw = new Stopwatch();
      sw.Start();

      HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
      request.AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate;
      request.Credentials = CredentialCache.DefaultCredentials;
      request.Proxy.Credentials = CredentialCache.DefaultCredentials;
      request.Timeout = Settings.Default.Timeout;

      HttpWebResponse response = (HttpWebResponse)request.GetResponse();

      Stream dataStream = response.GetResponseStream();
      StreamReader reader = new StreamReader(dataStream);
      string responseFromServer = reader.ReadToEnd();

      reader.Close();
      dataStream.Close();
      response.Close();

      sw.Stop();

      Log(String.Format("  Time: {0} ms, Size: {1} bytes", sw.ElapsedMilliseconds, responseFromServer.Length));

      Debug("responseFromServer: " + responseFromServer);

      // check if error (???)
      if (response.StatusCode == HttpStatusCode.OK || response.StatusCode == HttpStatusCode.Accepted)
      {
        // One of our ratting servers' exception starts with "onException"
        if (!responseFromServer.StartsWith("onException", StringComparison.InvariantCultureIgnoreCase))
          duration = sw.ElapsedMilliseconds;
      }

      return responseFromServer;
    }

    private void PrepareStat()
    {
      List<string> forUpdate = new List<string>();
      List<long> forUpdateIds = new List<long>();

      foreach (long id in pendingPlayers.Keys)
      {
        string cacheKey = id + "=" + pendingPlayers[id].vn;
        if (cache.ContainsKey(cacheKey))
        {
          PlayerInfo currentMember = cache[cacheKey];
          if (currentMember.notInDb)
            continue;
          if (!currentMember.httpError)
          {
            Log(string.Format("CACHE - {0} {1} {2}: eff={3} battles={4} wins={5} t-battles={6} t-wins={7}",
              id, pendingPlayers[id].name, pendingPlayers[id].vn,
              currentMember.stat.e, currentMember.stat.b, currentMember.stat.w,
              currentMember.stat.tb, currentMember.stat.tw));
            continue;
          }
          if (DateTime.Now.Subtract(currentMember.errorTime).Minutes < Settings.Default.ServerUnavailableTimeout)
            continue;
          cache.Remove(cacheKey);
        }

        // playerId=vname,... || playerId,...
        forUpdate.Add(String.IsNullOrEmpty(pendingPlayers[id].vn) ? id.ToString()
          : String.Format("{0}={1}{2}", id, pendingPlayers[id].vn, pendingPlayers[id].me == 1 ? "=1" : ""));
        forUpdateIds.Add(id);
      }

      if (forUpdate.Count == 0 || ServiceUnavailable())
        return;

      try
      {
        String reqMembers = String.Join(",", forUpdate.ToArray());

        // The character "?" may be used in china server as the username,
        // for example  "?ABC" . So it's must be replace to "%3F" for search.
        if (reqMembers.IndexOf('?') > 0)
          reqMembers = reqMembers.Replace("?", "%3F");

        string responseFromServer = loadUrl(_currentProxyUrl, reqMembers);

        Response res = JsonDataToResponse(JsonMapper.ToObject(responseFromServer));
        if (res == null || res.players == null)
        {
          Log("WARNING: empty response or parsing error");
          return;
        }

        foreach (Stat stat in res.players)
        {
          if (pendingPlayers.ContainsKey(stat.id))
          {
            string cacheKey = stat.id + "=" + pendingPlayers[stat.id].vn;
            if (String.IsNullOrEmpty(stat.name))
              continue;
            cache[cacheKey] = new PlayerInfo()
            {
              stat = stat,
              httpError = false
            };
            if (String.IsNullOrEmpty(cache[cacheKey].stat.name))
              cache[cacheKey].stat.name = pendingPlayers[stat.id].name;
            cache[cacheKey].stat.clan = pendingPlayers[stat.id].clan;
          }
          else
          {
            Log("WARNING: pendingPlayers key not found for id=" + stat.id + "\n" + JsonMapper.ToJson(stat));
          }
        };

        // disable stat retrieving for people in cache, but not in server db
        foreach (long id in forUpdateIds)
        {
          string cacheKey = id + "=" + pendingPlayers[id].vn;
          if (cache.ContainsKey(cacheKey))
            continue;

          cache[cacheKey] = new PlayerInfo()
          {
            stat = new Stat()
            {
              id = id,
              name = pendingPlayers[id].name,
              clan = pendingPlayers[id].clan,
            },
            httpError = false,
            notInDb = true
          };

          Debug(String.Format("Player [{0}] {1} not in Database", id, pendingPlayers[id].name));
        };
        _modInfo = res.info;
      }
      catch (Exception ex)
      {
        Log(string.Format("Exception: {0}", ex));
        ErrorHandle();
        for (var i = 0; i < forUpdateIds.Count; i++)
        {
          long id = forUpdateIds[i];
          string cacheKey = id + "=" + pendingPlayers[id].vn;
          cache[cacheKey] = new PlayerInfo()
          {
            stat = new Stat()
            {
              id = id,
              name = pendingPlayers[id].name,
              clan = pendingPlayers[id].clan,
            },
            httpError = true,
            errorTime = DateTime.Now
          };
        }
      }
    }

    private static int ParseInt(JsonData data, params String[] path)
    {
      try
      {
        for (int i = 0; i < path.Length - 1; ++i)
          data = data[path[i]];
        return data[path[path.Length - 1]].IsInt ? int.Parse(data[path[path.Length - 1]].ToString()) : 0;
      }
      catch
      {
        return 0;
      }
    }

    private static long ParseLong(JsonData data, params String[] path)
    {
      try
      {
        for (int i = 0; i < path.Length - 1; ++i)
          data = data[path[i]];
        return (data[path[path.Length - 1]].IsInt || data[path[path.Length - 1]].IsLong)
            ? long.Parse(data[path[path.Length - 1]].ToString()) : 0;
      }
      catch
      {
        return 0;
      }
    }

    private static string ParseString(JsonData data, params String[] path)
    {
      try
      {
        for (int i = 0; i < path.Length - 1; ++i)
          data = data[path[i]];
        return data[path[path.Length - 1]].IsString ? data[path[path.Length - 1]].ToString() : "";
      }
      catch
      {
        return "";
      }
    }

    private Response JsonDataToResponse(JsonData jd)
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
              id = ParseLong(data, "id"),
              name = ParseString(data, "name"),
              vn = ParseString(data, "vname"),
              b = ParseInt(data, "battles"),
              w = ParseInt(data, "wins"),
              e = ParseInt(data, "eff"),
              tb = ParseInt(data, "v", "b"),
              tw = ParseInt(data, "v", "w"),
              tl = ParseInt(data, "v", "l"),
              ts = ParseInt(data, "v", "s"),
              td = ParseInt(data, "v", "d"),
              tf = ParseInt(data, "v", "f"),
            };
          }
        }
      }
      catch (Exception ex)
      {
        Log("Parse error: players: " + ex);
      }

      try
      {
        if (jd["info"] == null)
          return res;

        res.info = new Info();
        if (jd["info"][version] != null)
        {
          JsonData data = jd["info"][version];
          res.info.xvm = new XVMInfo()
          {
            ver = data["ver"].ToString(),
            message = data["message"].ToString(),
          };
        }
      }
      catch (Exception ex)
      {
        Log("Parse error: info: " + ex);
      }

      return res;
    }

    #endregion

    #region Log processing

    private int logLength = 0;
    private string logString = "";

    private void ProcessLog(string parameters)
    {
      if (parameters.Contains(","))
      {
        if (!String.IsNullOrEmpty(logString))
        {
          Log("Warning: incomplete @LOG string");
          DecodeAndPrintLogString();
        }
        logString = "";
        try
        {
          string[] strArray = parameters.Split(',');
          logLength = int.Parse(strArray[0], System.Globalization.NumberStyles.HexNumber);
          parameters = strArray[1];
        }
        catch
        {
          logLength = 0;
          Log("Error parsing @LOG command parameters");
        }
      }

      if (logLength == 0)
        return;

      logString += parameters;
      if (logLength <= logString.Length)
        DecodeAndPrintLogString();
    }

    private void DecodeAndPrintLogString()
    {
      List<byte> buf = new List<byte>();
      try
      {
        for (int i = 0; i < logString.Length - 1; i += 2)
        {
          byte b = Convert.ToByte(logString.Substring(i, 2), 16);
          if (b < 32 && b != 10 && b != 13 && b != 9) // '\n', '\r', '\t'
            b = 63; // '?'
          buf.Add(b);
        }
        Log(Encoding.ASCII.GetString(buf.ToArray()));
      }
      catch (Exception ex)
      {
        Log("Error decoding @LOG string: " + Encoding.ASCII.GetString(buf.ToArray()));
        Debug(logString);
        Debug(ex.ToString());
      }
      finally
      {
        logLength = 0;
        logString = "";
      }
    }
    #endregion

  }
}
