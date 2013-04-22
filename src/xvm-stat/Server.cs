using Dokan;
using LitJson;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Xml;
using wot.Properties;
using System.Globalization;

namespace wot
{
  class Server : DokanOperations
  {
    #region Private Members

    [Serializable]
    public class PlayerData
    {
      public long id;         // player id
      public string n;        // full player name
      public string v;        // vehicle key
      public byte s;          // selected
      public byte t;          // team

      internal string _label { get { return n.GetNormalizedPlayerName(); } }
      internal string _clan { get { return n.GetClanName(); } }
    }

    [Serializable]
    public class Stat
    {
      public long id;         // player id
      public string name;     // normalized player name
      public string clan;     // clan
      public string vn;       // vehicle key
      public int b;           // total battles
      public int w;           // total wins
      public int e;           // global efficiency
      public int spo;         // spotted
      public int hip;         // hits percent
      public int cap;         // capture points
      public int dmg;         // damage dealt
      public int frg;         // frags
      public int def;         // dropped capture points
      public double avglvl;   // average level of tanks
      public int wn;          // WN rating: http://www.koreanrandom.com/forum/topic/2575-
      public int twr;         // tourist1984 win rate: http://www.koreanrandom.com/forum/topic/2389-
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

    public class Result
    {
      public string result;
      public Thread thread;
      // optional
      public List<PlayerData> players;
    }

    // local info cache for user data
    private readonly Dictionary<string, string> infocache = new Dictionary<string, string>();
    // local cache (key => "id=vname")
    private readonly Dictionary<string, Stat> cache = new Dictionary<string, Stat>();
    private readonly List<Result> results = new List<Result>();
    private int lastResultId = -1;
    private readonly String[] proxies;
    private Info modInfo;
    private readonly Dictionary<string, string> vars = new Dictionary<string, string>();

    private readonly object _lock = new object();
    private readonly object _lockNetwork = new object();
    private readonly object _lockResults = new object();
    public String version;
    #endregion

    #region .ctor()

    public Server(String ver)
    {
      Log(string.Format("Timeout: {0}, MountPoint: {1}", Settings.Default.Timeout, Settings.Default.MountPoint));

      //check version
      version = String.IsNullOrEmpty(ver) ? GetVersion() : ver;
      Log(string.Format("Game Region: {0}{1}", version, String.IsNullOrEmpty(ver) ? " (detected)" : ""));
      proxies = GetProxyAddresses();
    }

    #endregion

    #region service functions

    private static void Log(string message)
    {
      Program.Log(message);
    }

    private static void Debug(string message)
    {
      Program.Debug(message);
    }

    private static void DebugFS(string message)
    {
      Program.DebugFS(message);
    }

    private static void LogStat(string message)
    {
        Program.LogStat(message);
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
          if (s.LastIndexOf("http://update.wot.ru.wargaming.net") > -1 || s.LastIndexOf("http://update.worldoftanks.ru") > -1)
            wotVersion = "RU";
          else if (s.LastIndexOf("http://update.worldoftanks.com") > -1)
            wotVersion = "US";
          else if (s.LastIndexOf("http://update.worldoftanks.eu") > -1)
            wotVersion = "EU";
          else if (s.LastIndexOf("http://update.worldoftanks.cn") > -1)
            wotVersion = "CN";
          else if (s.LastIndexOf("http://update.worldoftanks-sea.com") > -1)
            wotVersion = "SEA";
          else if (s.LastIndexOf("http://update.worldoftanks.vn") > -1)
            wotVersion = "VTC";
          else if (s.LastIndexOf("http://update.worldoftanks.kr") > -1)
            wotVersion = "KR";
          else if (s.LastIndexOf("http://update-ct.wargaming.net/") > -1)
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
      //DebugFS("CREATE_FILE");
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
      DebugFS("WRITE_FILE");
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

    private string _command = "";
    private const string EMPTY_RESULT = "{\"status\":\"EMPTY\"}";
    private const string BAD_REQUEST_RESULT = "{\"status\":\"BAD_REQUEST\"}";
    private string _result = EMPTY_RESULT;
    public int GetFileInformation(String filename, FileInformation fileinfo, DokanFileInfo info)
    {
      DebugFS("GetFileInformation(): " + filename);
      lock (_lock)
      {
        try
        {
          DateTime now = DateTime.Now;
          fileinfo.FileName = filename;
          fileinfo.Attributes = FileAttributes.Archive;
          fileinfo.CreationTime = now;
          fileinfo.LastAccessTime = now;
          fileinfo.LastWriteTime = now;
          fileinfo.Length = 0;

          // XP send filename in lowercase, W7 in uppercase. Make them both the same.
          String command = Path.GetFileName(filename).ToUpper();

          if (_command == command)
          {
            fileinfo.Length = _result.Length;
            return 0;
          }

          _command = command;

          // TODO: Client is freezing when no data received
          //fileinfo.Length = _result.Length; return 0;

          if (String.IsNullOrEmpty(command) || command[0] != '@')
          {
            _result = BAD_REQUEST_RESULT;
            fileinfo.Length = _result.Length;
            return 0;
          }

          _result = EMPTY_RESULT;
          fileinfo.Length = _result.Length;

          String parameters = "";
          if (command.Contains(" "))
          {
            string[] cmd = command.Split(new char[] { ' ' }, 2);
            command = cmd[0];
            parameters = cmd[1];
          }

          if (!command.StartsWith("@LOG") && command != "@SET" && command != "@ADD")
            Log(String.Format("=> {0} {1}", command, parameters));

          ProcessCommand(command, parameters);
        }
        catch (Exception ex)
        {
          Log("GetFileInformation(): Error: " + ex);
          _result = String.Format("{{\"status\":\"ERROR\",\"error\":\"EXCEPTION: {0}\"}}", ex.Message);
        }
        finally
        {
          fileinfo.Length = _result.Length;
        }

        return 0;
      }
    }

    private void ProcessCommand(String command, String parameters)
    {
      switch (command)
      {
        // SYNC

        // Encoded

        case "@LOG": // args - encoded log string
          ProcessLog(parameters, LogDestination.Log);
          break;

        case "@LOGSTAT": // args - encoded log string
          ProcessLog(parameters, LogDestination.Stats);
          break;

        case "@SET": // args - set of players
        case "@ADD": // args - set of players
          ProcessSetAddCommand(command, parameters);
          break;

        // Flat

        case "@VAR": // args - variable=value
          ProcessVarCommand(parameters);
          break;

        case "@GET_VERSION":
          ProcessGetVersionCommand();
          Debug("_result: " + _result);
          break;

        case "@GET_PLAYERS": // no args
          ProcessGetPlayersCommand();
          Debug("_result: " + _result);
          break;

        // ASYNC

        case "@GET_ASYNC": // args - resultId requestCount
          ProcessGetAsyncCommand(parameters);
          Debug("_result: " + _result);
          break;

        case "@INFO_ASYNC": // args - resultId requestCount params
          ProcessInfoAsyncCommand(parameters);
          Debug("_result: " + _result);
          break;

        case "@PING": // no args
          _result = PingWotServers.Instance.Ping();
          //Debug("_result: " + _result);
          break;

        default:
          Log("Unknown command: " + command);
          break;
      }
    }

    private void ProcessSetAddCommand(String command, String parameters)
    {
      string value = CollectParts(parameters);
      if (!String.IsNullOrEmpty(value))
      {
        Debug(String.Format("{0} {1}", command, value));
        if (command == "@SET")
        {
          lock (_lockResults)
          {
            results.Add(new Result() { result = null, thread = null, players = new List<PlayerData>() });
            lastResultId = results.Count - 1;
          }
        }
        AddPendingPlayers(value, lastResultId);
      }
      _result = String.Format("{{\"resultId\":{0}}}", lastResultId);
    }

    private void ProcessVarCommand(String parameters)
    {
      string[] v = parameters.Split(new char[] { '=' }, 2);
      if (v.Length < 2)
        throw new Exception("Bad variable received: " + parameters);
      Log("SET VAR: " + parameters);
      vars[v[0].Trim()] = v[1];
    }

    private void ProcessGetVersionCommand()
    {
      _result = String.Format("{0}\n{1}", version, Path.GetDirectoryName(Assembly.GetEntryAssembly().Location));
      foreach (string v in vars.Keys)
        _result += String.Format("\n{0}={1}", v, vars[v]);
    }

    private void ProcessGetPlayersCommand()
    {
      if (lastResultId < 0)
        throw new Exception("No last result: " + lastResultId);
      lock (_lockResults)
      {
        if (results[lastResultId].players == null)
          throw new Exception("No players: " + lastResultId);
        _result = JsonMapper.ToJson(results[lastResultId].players);
      }
    }

    private void ProcessGetAsyncCommand(String parameters)
    {
      _result = AsyncWrapper(parameters, (resultId, arg) =>
        {
          lock (_lockNetwork)
          {
            Result r;
            lock (_lockResults)
            {
              r = results[resultId];
            }
            string res = GetStat(r); // this will start network operations
            lock (_lockResults)
            {
              results[resultId].result = !string.IsNullOrEmpty(res) ? res
                : String.Format("{{\"status\":\"ERROR\",\"error\":\"no result: {0}\"}}", resultId);
              results[resultId].thread = null;
            }
            //Debug("Loaded: " + resultId);
          }
        });
    }

    private void ProcessInfoAsyncCommand(String parameters)
    {
      _result = AsyncWrapper(parameters, (resultId, arg) =>
                {
                  lock (_lockNetwork)
                  {
                    string res = GetInfo(arg); // this will start network operations
                    lock (_lockResults)
                    {
                      results[resultId].result = !string.IsNullOrEmpty(res) ? res
                        : String.Format("{{\"status\":\"ERROR\",\"error\":\"no result: {0}\"}}", resultId);
                      results[resultId].thread = null;
                    }
                    //Debug("Loaded: " + resultId);
                  }
                });
    }

    private string _lastReadFileFilenameAndOffset = "";
    public int ReadFile(String filename, Byte[] buffer, ref uint readBytes, long offset, DokanFileInfo info)
    {
      DebugFS(String.Format("ReadFile(): {0}:{1} {2}", offset, buffer.Length, filename));
      lock (_lock)
      {
        if (String.IsNullOrEmpty(_result))
          return 0;

        using (MemoryStream ms = new MemoryStream(Encoding.ASCII.GetBytes(_result)))
        {
          ms.Seek(offset, SeekOrigin.Begin);
          readBytes = (uint)ms.Read(buffer, 0, buffer.Length);
        }

        // Avoid double requests
        string filenameAndOffset = String.Format("{0}:{1}", filename, offset);
        if (filenameAndOffset != _lastReadFileFilenameAndOffset)
        {
          _lastReadFileFilenameAndOffset = filenameAndOffset;
          if (_command.Contains("_ASYNC") && !_result.Contains("\"NOT_READY\"") ||
            _command.StartsWith("@GET_PLAYERS "
          ))
          {
            Log(String.Format("Read {0} bytes {1}", readBytes, _command));
          }
        }
      }
      return 0;
    }
    #endregion

    #region AsyncWrapper

    private string AsyncWrapper(string parameters, Action<int, string> threadFunc)
    {
      if (string.IsNullOrEmpty(parameters))
        throw new Exception("Empty resultId");
      int resultId;
      string[] p = parameters.Split(new char[] { ' ' }, 3, StringSplitOptions.RemoveEmptyEntries);
      if (!int.TryParse(p[0], out resultId) || resultId < -1 || resultId > results.Count - 1)
        throw new Exception("Invalid resultId: " + p[0]);

      lock (_lockResults)
      {
        if (resultId == -1)
        {
          results.Add(new Result() { result = null, thread = null });
          resultId = results.Count - 1;
        }

        if (results[resultId].result != null)
          return results[resultId].result;

        if (results[resultId].thread == null)
        {
          results[resultId].thread = new Thread(() => { threadFunc(resultId, p.Length < 3 ? "" : p[2]); });
          results[resultId].thread.Start();
        }
        return String.Format("{{\"status\":\"NOT_READY\",\"resultId\":{0}}}", resultId);
      }
    }

    #endregion

    #region Network operations

    // Get fastest proxy servers (with minimal ping)
    private string[] GetProxyAddresses()
    {
      List<string> ps = new List<string>();
      foreach (string server in Settings.Default.ProxyServers)
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

      // Select fastest
      long minTime = long.MaxValue;
      List<string> proxyUrl = new List<string>();
      Dictionary<string, long> proxyUrls = new Dictionary<string, long>();

      foreach (string addr in ps)
      {
        string tempUrl = Encoding.ASCII.GetString(Convert.FromBase64String(addr));

        long tmpTime = long.MaxValue;
        try
        {
          loadUrl(tempUrl, "test", out tmpTime, true);
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

      return proxyUrl.ToArray();
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
      url = url.Replace("%1", members).Replace("%2", Program.PublicKeyToken);
      duration = long.MaxValue;

      Stopwatch sw = new Stopwatch();
      sw.Start();

      HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
      request.AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate;
      request.Credentials = CredentialCache.DefaultCredentials;
      if (!Program.isNoProxy)
        request.Proxy.Credentials = CredentialCache.DefaultCredentials;
      else
        request.Proxy = new WebProxy();
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

    #endregion

    #region AddPendingPlayers

    private void AddPendingPlayers(String value, int resultId)
    {
        JsonData jd = JsonMapper.ToObject(value);
        long id = jd.ToLong("id");

        // Check duplicate result
        if (results[resultId].players.Exists(x => x.id == id))
          return;

        results[resultId].players.Add(new PlayerData()
        {
          id = id,
          n = jd.ToString("n"),
          v = jd.ToString("v"),
          t = (byte)jd.ToInt("t"),
          s = (byte)jd.ToInt("s"),
        });
    }

    #endregion

    #region Stat operations

    private string GetStat(Result req)
    {
      try
      {
        PrepareStat(req);

        Response res = new Response()
        {
          players = new Stat[req.players.Count],
          info = modInfo,
        };

        int pos = 0;
        foreach (PlayerData pd in req.players)
        {
          string cacheKey = String.Format("{0}={1}", pd.id, pd.v);
          if (cache.ContainsKey(cacheKey))
          {
            res.players[pos] = cache[cacheKey];
            // fix player names (for CT)
            res.players[pos].name = pd._label;
            pos++;
          }
        }
        Array.Resize<Stat>(ref res.players, pos);

        Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
        return JsonMapper.ToJson(res);
      }
      catch
      {
        return "{{\"status\":\"ERROR\",\"error\":\"EXCEPTION\"}}";
      }
    }

    private void PrepareStat(Result req)
    {
      string updateRequest = "";
      foreach (PlayerData pd in req.players)
      {
        string cacheKey = String.Format("{0}={1}", pd.id, pd.v);
        if (cache.ContainsKey(cacheKey) && pd.s != 1)
          continue;

        // playerId=vname,... || playerId,...
        if (!string.IsNullOrEmpty(updateRequest))
          updateRequest += ",";
        updateRequest += String.IsNullOrEmpty(pd.v) ? pd.id.ToString()
          : String.Format("{0}={1}{2}", pd.id, pd.v, pd.s == 1 ? "=1" : "");
      }

      if (string.IsNullOrEmpty(updateRequest))
        return;

      try
      {
        // The character "?" may be used in china server as the username,
        // for example  "?ABC" . So it's must be replace to "%3F" for search.
        updateRequest = updateRequest.Replace("?", "%3F");

        string responseFromServer = loadUrl(proxies[(new Random()).Next(proxies.Length)], updateRequest);

        Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
        Response res = JsonDataToResponse(JsonMapper.ToObject(responseFromServer));
        if (res == null || res.players == null)
        {
          Log("WARNING: empty response or parsing error");
          return;
        }

        // save mod info
        if (res.info != null)
          modInfo = res.info;

        foreach (Stat stat in res.players)
        {
          if (String.IsNullOrEmpty(stat.name))
            continue;
          string cacheKey = String.Format("{0}={1}", stat.id, stat.vn);
          cache[cacheKey] = stat;
          PlayerData pd = req.players.Find(x => x.id == stat.id);
          if (pd != null)
          {
            cache[cacheKey].name = pd._label;
            cache[cacheKey].vn = pd.v;
            cache[cacheKey].clan = pd._clan;
          }
        };

        // disable stat retrieving for people in cache, but not in server db
        foreach (PlayerData pd in req.players)
        {
          string cacheKey = String.Format("{0}={1}", pd.id, pd.v);
          if (cache.ContainsKey(cacheKey))
            continue;
          Debug(String.Format("Player {0} {1} {2} not in Database", pd.id, pd.v, pd.n));
          cache[cacheKey] = new Stat()
            {
              id = pd.id,
              vn = pd.v,
              name = pd._label,
              clan = pd._clan,
            };
        };
      }
      catch (Exception ex)
      {
        Log(string.Format("Exception: {0}", ex));
      }
    }
    #endregion

    #region Stat parsing

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
              id = data.ToLong("id"),
              name = data.ToString("name"),
              vn = data.ToString("vname"),
              b = data.ToInt("battles"),
              w = data.ToInt("wins"),
              e = data.ToInt("eff"),
              spo = data.ToInt("spo"),
              hip = data.ToInt("hip"),
              cap = data.ToInt("cap"),
              dmg = data.ToInt("dmg"),
              frg = data.ToInt("frg"),
              def = data.ToInt("def"),
              avglvl = data.ToDouble("lvl"),
              wn = data.ToInt("wn"),
              twr = data.ToInt("twr"),
              tb = data.ToInt("v", "b"),
              tw = data.ToInt("v", "w"),
              tl = data.ToInt("v", "l"),
              ts = data.ToInt("v", "s"),
              td = data.ToInt("v", "d"),
              tf = data.ToInt("v", "f"),
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

    #region @INFO
    private string GetInfo(string req)
    {
      if (string.IsNullOrEmpty(req))
        return "{{\"status\":\"ERROR\",\"error\":\"NO_REQ\"}}";

      List<byte> buf = new List<byte>();
      string s = "";
      try
      {
        for (int i = 0; i < req.Length - 1; i += 2)
        {
          byte b = Convert.ToByte(req.Substring(i, 2), 16);
          buf.Add(b);
        }

        s = Encoding.UTF8.GetString(buf.ToArray());
        if (s.Contains(",")) {
            string[] sa = s.Split(',');
            s = String.Format("{0}/{1}", sa[1], sa[0]);
        }
      }
      catch (Exception ex)
      {
        Log("Error decoding @INFO string: " + Encoding.ASCII.GetString(buf.ToArray()));
        Debug(req);
        Debug(ex.ToString());
        return "{{\"status\":\"ERROR\",\"error\":\"EXCEPTION\"}}";
      }
      
      string key = "@INFO/" + s;
      if (infocache.ContainsKey(key))
        return infocache[key];

      try
      {
        // The character "?" may be used in china server as the username,
        // for example  "?ABC" . So it's must be replace to "%3F" for search.
        s = s.Replace("?", "%3F");

        string response = loadUrl(proxies[(new Random()).Next(proxies.Length)], "INFO/" + s);
        if (string.IsNullOrEmpty(response))
          return "{{\"status\":\"ERROR\",\"error\":\"NO_DATA\"}}";
        infocache[key] = response;
        return response;
      }
      catch (Exception ex)
      {
        Log(string.Format("Exception: {0}", ex));
        return "{{\"status\":\"ERROR\",\"error\":\"EXCEPTION\"}}";
      }
    }
    #endregion

    #region Log processing

    enum LogDestination {Log, Stats};

    private void ProcessLog(string parameters, LogDestination logDestination)
    {
      string value = CollectParts(parameters);
      if (String.IsNullOrEmpty(value))
        return;
      if (logDestination == LogDestination.Log)
        Log(value);
      else
        LogStat(value);
    }

    #endregion

    #region DecodeString

    private class Parts
    {
      public string value;
      public int len;
      public List<string> parts;
      
      public Parts()
      {
        value = null;
        len = -1;
        parts = new List<string>();
      }

      public bool IsComplete()
      {
        if (value != null)
          return true;
        string v = "";
        for (int i = 0; i < parts.Count; ++i)
        {
          if (String.IsNullOrEmpty(parts[i]))
            return false;
          v += parts[i];
        }
        if (v.Length == len)
          value = DecodeString(v);
        return value != null;
      }

      public void SetPart(int id, string value)
      {
        while (parts.Count - 1 < id)
          parts.Add(String.Empty);
        parts[id] = value;
      }
    }

    private readonly Dictionary<string, Parts> parts = new Dictionary<string, Parts>();

    private string CollectParts(String parameters)
    {
      try
      {
        string[] pa = parameters.Split(new char[] { ',' }, 3); // cmdid, partid, data
        string cmdId = pa[0];
        int partId = int.Parse(pa[1], NumberStyles.HexNumber);
        parameters = pa[2];

        if (cmdId.StartsWith("_"))
          Log("Warning: unknown SWF sandbox");

        if (!parts.ContainsKey(cmdId))
          parts[cmdId] = new Parts();

        Parts part = parts[cmdId];

        if (partId == 0)
        {
          string[] pb = parameters.Split(',');
          part.len = int.Parse(pb[0], NumberStyles.HexNumber);
          parameters = pb[1];
        }

        part.SetPart(partId, parameters);

        if (!part.IsComplete())
          return null;

        string res = part.value;
        parts.Remove(cmdId);
        return res;
      }
      catch (Exception ex)
      {
        Log("Error: " + ex);
      }

      return null;
    }

    private static string DecodeString(string str)
    {
      List<byte> buf = new List<byte>();
      for (int i = 0; i < str.Length - 1; i += 2)
      {
        byte b = Convert.ToByte(str.Substring(i, 2), 16);
        buf.Add(b);
      }
      return Encoding.UTF8.GetString(buf.ToArray());
    }

    #endregion

  }
}
