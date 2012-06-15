﻿using System;
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
      public int id;          // player id
      public String name;     // player name
      public String clan;     // clan
      public String vn;       // vehicle name
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
    private readonly Dictionary<int, Stat> pendingPlayers = new Dictionary<int, Stat>();

    private Info _modInfo = null;
    private bool _firstError = true;
    private bool _unavailable = false;
    private DateTime _unavailableFrom;
    private String _lastResult = "";
    private readonly String _currentProxyUrl;
    private bool added = false;
    private Thread runningIngameThread;

    private readonly object _lockIngame = new object();
    public String version;
    #endregion

    #region .ctor()

    public Server(String ver)
    {
      Log(2, string.Format("LogLevel: {1}{0}MountPoint: {2}{0}Timeout: {3}",
        Environment.NewLine,
        Settings.Default.LogLevel,
        Settings.Default.MountPoint,
        Settings.Default.Timeout));

      //check version
      version = String.IsNullOrEmpty(ver) ? GetVersion() : ver;
      _currentProxyUrl = GetProxyAddress();
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
      lock (_lockIngame)
      {
        String[] chunks = parameters.Split(',');
        foreach (String chunk in chunks)
        {
          String[] param = chunk.Split(new char[] { '=' }, 2, StringSplitOptions.RemoveEmptyEntries);
          if (param.Length != 2)
            continue;

          int id = int.Parse(param[0]);
          if (pendingPlayers.ContainsKey(id))
            continue;

          String[] param2 = param[1].Split(new char[] { '&' }, 2, StringSplitOptions.RemoveEmptyEntries);

          string name = param2[0];
          string clan = "";
          if (name.Contains("["))
          {
            clan = name.Split(new char[] { '[', ']' }, 3)[1];
            name = name.Remove(name.IndexOf("["));
          }

          string vname = param2.Length > 1 ? param2[1] : "";

          pendingPlayers[id] = new Stat()
          {
            id = id,
            name = name,
            clan = clan,
            vn = vname,
          };
        }
        added = true;
      }
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
          if (s.LastIndexOf("http://update.worldoftanks.cn/") > -1)
            wotVersion = "CN1";
          else if (s.LastIndexOf("http://update.wot.ru.wargaming.net") > -1 ||
            s.LastIndexOf("http://update.worldoftanks.ru") > -1)
          {
            wotVersion = "RU";
          }
          else if (s.LastIndexOf("http://update.worldoftanks.com") > -1)
            wotVersion = "NA";
          else if (s.LastIndexOf("http://update.worldoftanks.eu") > -1)
            wotVersion = "EU";
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
      Log(2, string.Format("WoT version is: {0}", wotVersion));

      return (wotVersion);
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
    private string _temp = null;

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

          if (filename == _prevCommand)
          {
            if (!String.IsNullOrEmpty(_prevResult))
              fileinfo.Length = _prevResult.Length;
            return 0;
          }

          _prevCommand = filename;
          _prevResult = _prevResult == "FINISHED" ? _temp : "";

          if (!filename.StartsWith("\\@LOG"))
            Log(1, String.Format("=> GetFileInformation({0})", filename));
          String command = Path.GetFileName(filename);
          if (String.IsNullOrEmpty(command) || command[0] != '@')
            return 0;

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

            case "@GET_VERSION":
              _prevResult = version + "\n" +
                Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
;
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
        if (String.Compare(filename, "\\@RETRIEVE", true) == 0 &&
          (String.IsNullOrEmpty(_prevResult) || _prevResult == "FINISHED")) {
          _prevResult = _lastResult;
          Debug("Retrieving");
        }
        if (!String.IsNullOrEmpty(_prevResult))
        {
          using (MemoryStream ms = new MemoryStream(Encoding.ASCII.GetBytes(_prevResult)))
          {
            ms.Seek(offset, SeekOrigin.Begin);
            readBytes = (uint)ms.Read(buffer, 0, buffer.Length);
            Log(1, String.Format("Read {0} bytes", readBytes));
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
      foreach (int id in pendingPlayers.Keys)
      {
        string cacheKey = id + "=" + pendingPlayers[id].vn;
        if (cache.ContainsKey(cacheKey))
        {
          res.players[pos] = cache[cacheKey].stat;
          // fix CT player names
          if (version == "CT")
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
          string testId = (version.StartsWith("CN", StringComparison.InvariantCultureIgnoreCase))
            ? "test" : "001";
          loadUrl(tempUrl, testId, out tmpTime);
        }
        catch (Exception ex)
        {
          Log(1, string.Format("Exception: {0}", ex));
        }

        Log(0, "urlload - " + tmpTime);

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

    private static string loadUrl(string url, string members, out long duration)
    {
      Log(1, "HTTP - " + members);
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

      Log(1, String.Format("  Time: {0} ms, Size: {1} bytes",
        sw.ElapsedMilliseconds, responseFromServer.Length));

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
      List<int> forUpdateIds = new List<int>();

      foreach (int id in pendingPlayers.Keys)
      {
        string cacheKey = id + "=" + pendingPlayers[id].vn;
        if (cache.ContainsKey(cacheKey))
        {
          PlayerInfo currentMember = cache[cacheKey];
          if (currentMember.notInDb)
            continue;
          if (!currentMember.httpError)
          {
            Log(1, string.Format("CACHE - {0} {1} {2}: eff={3} battles={4} wins={5} t-battles={6} t-wins={7}",
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
          : String.Format("{0}={1}", id, pendingPlayers[id].vn));
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
          Log(2, "WARNING: empty response or parsing error");
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
            Log(2, "WARNING: pendingPlayers key not found for id=" + stat.id);
            Log(1, JsonMapper.ToJson(stat));
          }
        };

        // disable stat retrieving for people in cache, but not in server db
        foreach (int id in forUpdateIds)
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
        Log(2, string.Format("Exception: {0}", ex));
        ErrorHandle();
        for (var i = 0; i < forUpdateIds.Count; i++)
        {
          int id = forUpdateIds[i];
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
              id = ParseInt(data, "id"),
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
        Log(2, "Parse error: players: " + ex);
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
        Log(2, "Parse error: info: " + ex);
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
          Log(1, "Warning: incomplete @LOG string");
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
          Log(1, "Error parsing @LOG command parameters");
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
        Log(1, Encoding.ASCII.GetString(buf.ToArray()));
      }
      catch (Exception ex)
      {
        Log(1, "Error decoding @LOG string: " + Encoding.ASCII.GetString(buf.ToArray()));
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
