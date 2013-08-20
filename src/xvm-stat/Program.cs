using Dokan;
using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Threading;
using wot.Properties;

namespace wot
{
  class Program
  {
    public static string PublicKeyToken = String.Empty;

    private const string WOT_PROCESS_NAME = "WorldOfTanks";
    private const string WOT_EXE_FILE_NAME = WOT_PROCESS_NAME + ".exe";

    private static string wotExeFileName = WOT_EXE_FILE_NAME;
    private static bool isLauncher = false;
    public static bool isDebug = false;

    public static string priority = null;
    public static string serverVersion = null;
    private static bool isNoAuto = false;
    public static bool isNoProxy = false;
    public static bool isMaximized = false;
    public static bool isMkbundle = false;

    private static Process wotProcess = null;

    static Program()
    {
      AppDomain.CurrentDomain.AssemblyResolve += Resolver;
      AppDomain.CurrentDomain.UnhandledException += UnhandledException;
    }

    static Assembly Resolver(object sender, ResolveEventArgs args)
    {
      Assembly a1 = Assembly.GetExecutingAssembly();
      string resName = "";
      if (args.Name.StartsWith("Community.CsharpSqlite"))
        resName = "wot.Sqlite.Community.CsharpSqlite.dll";
      Stream s = a1.GetManifestResourceStream(resName);
      byte[] block = new byte[s.Length];
      s.Read(block, 0, block.Length);
      Assembly a2 = Assembly.Load(block);
      return a2;
    }

    private static void Usage()
    {
      Log("Usage: xvm-stat.exe [options] [file.wotreplay]");
      Log("Options:");
      Log("  /launcher - run launcher instead of game");
      Log("  /noauto - do not run game automatically");
      Log("  /noproxy - do not use IE proxy settings");
      Log("  /maximized - maximized game window");
      Log("  /debug - run in debug mode (extended log)");
      Log("  /server=(RU|EU|US|CN|SEA|VTC|KR|CT) - select server (disable autodetection)");
      Log("  /priority=(Idle|BelowNormal|Normal|AboveNormal|High|RealTime) - set process priority, default is Normal");
      Log("  file.wotreplay - play replay");
      Log("Press any key to exit.");
      Console.ReadKey(true);
    }

    private readonly static object _logLock = new object();
    public static void Log(string message, bool debug = false)
    {
      if (!debug || isDebug)
        Console.WriteLine((debug ? "DEBUG: " : "") + message);
      if (!Logger.IsActive)
        return;
     
      try
      {
        string timestamp = DateTime.Now.ToString("yyyy.MM.dd HH:mm:ss");
        string prefix = debug ? "[D]" : "[i]";
        string logstr = String.Format("{0} {1} ", timestamp, prefix);

        string[] lines = message.Split(new string[] { "\r", "\n" }, StringSplitOptions.RemoveEmptyEntries);
        for (int i = 1; i < lines.Length; i++)
          lines[i] = lines[i].PadLeft(lines[i].Length + logstr.Length);
        logstr += string.Join(Environment.NewLine, lines);

        Logger.LogAsync(logstr + Environment.NewLine);          
      }
      catch
      {
        // do nothing
      }
    }

    public static void Debug(string message)
    {
      Log(message, true);
    }

    public static void DebugFS(string message)
    {
      if (!isDebug)
        return;
      lock (_logLock)
      {
        try
        {
          string logstr = DateTime.Now.ToString("yyyy.MM.dd HH:mm:ss ");
          string[] lines = message.Split(new string[] { "\r", "\n" }, StringSplitOptions.RemoveEmptyEntries);
          for (int i = 1; i < lines.Length; i++)
            lines[i] = lines[i].PadLeft(lines[i].Length + logstr.Length);
          logstr += string.Join(Environment.NewLine, lines);
          File.AppendAllText("XVMfs.log", logstr + Environment.NewLine);
        }
        catch
        {
          // do nothing
        }
      }
    }

    public static void LogStat(string message)
    {
      lock (_logLock)
      {
        try
        {
          File.AppendAllText("xvm-stat.log", message + Environment.NewLine);
        }
        catch
        {
          // do nothing
        }
      }
    }

    private static bool CheckArgs(string[] args)
    {
      Debug("Processing command line arguments: " + String.Join(" ", args));
      for (int i = 0; i < args.Length; i++)
      {
        Debug(String.Format("  {0}: {1}", i, args[i]));
        if (String.Compare(args[i], "/?", true) == 0 || String.Compare(args[i], "/help", true) == 0)
        {
          Usage();
          return false;
        }

        if (String.Compare(args[i], "/launcher", true) == 0)
        {
          wotExeFileName = "WOTLauncher.exe";
          args[i] = "";
          isLauncher = true;
          continue;
        }

        if (String.Compare(args[i], "/debug", true) == 0)
        {
          args[i] = "";
          isDebug = true;
          Console.Title += " (DEBUG MODE)";
          Log("DEBUG MODE: ON");
          continue;
        }

        if (args[i].StartsWith("/server=", StringComparison.InvariantCultureIgnoreCase))
        {
          serverVersion = args[i].Substring(8);
          if (serverVersion.ToUpper() == "CN1")
            serverVersion = "CN";
          args[i] = "";
          continue;
        }
        
        if (args[i].StartsWith("/priority=", StringComparison.InvariantCultureIgnoreCase))
        {
          priority = args[i].Substring(10).ToLower();
          args[i] = "";
          continue;
        }

        if (String.Compare(args[i], "/noauto", true) == 0)
        {
          isNoAuto = true;
          args[i] = "";
          continue;
        }

        if (String.Compare(args[i], "/noproxy", true) == 0)
        {
          isNoProxy = true;
          args[i] = "";
          continue;
        }

        if (String.Compare(args[i], "/maximized", true) == 0)
        {
          isMaximized = true;
          args[i] = "";
          continue;
        }

        if (File.Exists(args[i]))
          args[i] = String.Format(@"""{0}""", args[i]);
      }

      return true;
    }

    private static void ClearLogFile()
    {
      try
      {
          Logger.Path = "XVM.log";
          Logger.Log(String.Format("{0:yyyy.MM.dd HH:mm:ss} {1}{2}", DateTime.Now, Console.Title, Environment.NewLine));       
      }
      catch
      {
        // do nothing
      }
    }

    private static void PrepareMountPoint(string mountPoint)
    {
      // Unmount MountPoint if left from previous start.
      Debug("Unmount previous mount");
      try
      {
        DokanNet.DokanRemoveMountPoint(mountPoint);
      }
      catch
      {
        // nothing
      }

      // Create MountPoint directory.
      Debug("Create MountPoint directory");
      DirectoryInfo di = new DirectoryInfo(mountPoint);
      if (di.Exists)
      {
        // try to delete old Dokan link.
        Debug("try to delete old Dokan link");
        FileAttributes fa = File.GetAttributes(mountPoint);
        if ((fa & FileAttributes.ReparsePoint) != 0)
        {
          try
          {
            Directory.Delete(mountPoint, false);
          }
          catch (Exception ex)
          {
            throw new Exception(String.Format("Cannot delete MountPoint file: {0}{1}{2}",
              mountPoint, Environment.NewLine, ex));
          }
          try
          {
            Directory.CreateDirectory(mountPoint);
          }
          catch (Exception ex)
          {
            throw new Exception(String.Format("Cannot create MountPoint directory: {0}{1}{2}",
              mountPoint, Environment.NewLine, ex));
          }
        }
        else
        {
          if (di.GetFileSystemInfos().Length != 0)
            throw new Exception("MountPoint directory exists and is not empty: " + mountPoint);
        }
      }
      else
      {
        try
        {
          Directory.CreateDirectory(mountPoint);
        }
        catch (Exception ex)
        {
          throw new Exception(String.Format("Cannot create MountPoint directory: {0}{1}{2}",
            mountPoint, Environment.NewLine, ex));
        }
      }
    }

    private static bool CheckFolderWritable(string path)
    {
        string filename = Path.Combine(path, ".xvmtest");
        try
        {
            StreamWriter writer = File.CreateText(filename);
            writer.Close();
            File.Delete(filename);
            return true;
        }
        catch
        {
            return false;
        }
    }

    private static bool Elevate(string[] args)
    {
        
        System.Security.Principal.WindowsIdentity id = System.Security.Principal.WindowsIdentity.GetCurrent();
        System.Security.Principal.WindowsPrincipal principal = new System.Security.Principal.WindowsPrincipal(id);
        if (principal.IsInRole(System.Security.Principal.WindowsBuiltInRole.Administrator))
            return true;

        ProcessStartInfo proc = new ProcessStartInfo
        {
            UseShellExecute = true,
            WorkingDirectory = Environment.CurrentDirectory,
            FileName = Assembly.GetExecutingAssembly().Location,
            Verb = "runas",
            Arguments = String.Join(" ", args),
        };

        try
        {
            Process.Start(proc);
        }
        catch
        {
            throw new Exception("Administrative privileges required to run from this folder.");
        }

        return false;
    }

    private static void Main(string[] args)
    {
      try
      {
        AssemblyInformationalVersionAttribute attribute =
           (AssemblyInformationalVersionAttribute)Assembly.GetExecutingAssembly()
           .GetCustomAttributes(typeof(AssemblyInformationalVersionAttribute), false)[0];

        var a = Assembly.GetExecutingAssembly().GetName();
        byte[] pt = a.GetPublicKeyToken();
        PublicKeyToken = "";
        for (int i = 0; i < pt.Length; i++)
          PublicKeyToken += String.Format("{0:x2}", pt[i]);

        Console.Title = String.Format("XVM Stat v{0} for XVM {1}+",
          Assembly.GetExecutingAssembly().GetName().Version, attribute.InformationalVersion);
        Log(Console.Title);

        // Check args
        string[] originalArgs = (string[])args.Clone();
        if (!CheckArgs(args))
          return;

        // CD to game dir
        string game_dir = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
        if (String.IsNullOrEmpty(game_dir)) //HACK: workaround against mkbundle behavior and bugs 
        {
          game_dir=Environment.CurrentDirectory;
          isMkbundle = true;
        }

        Debug("Change dir: " + game_dir);
        Directory.SetCurrentDirectory(game_dir);

        // --- DEBUG ----------------------------------------
        //Dossier.Dossier.Instance.GetDossierInfo("1;sirmax2;1381374000;3600;24;4;battlesCount,wins;;");
        //Thread.Sleep(1000);
        //return;
        // --- DEBUG ----------------------------------------

        // Check for another instance started
        bool ok;
        Mutex m = new Mutex(true, "xvm-stat", out ok);
        if (!ok)
          throw new Exception("Another proxy instance is already running.");
        GC.KeepAlive(m);

        // Check game start file exists
        Debug("Check start file exists: " + wotExeFileName);
        if (!File.Exists(wotExeFileName))
          throw new Exception("Game start file not found: " + wotExeFileName);

        // Check write permissions and elevate if needed. In this case, exit immediately as elevated process will be started
        if (!CheckFolderWritable(game_dir) && !Elevate(originalArgs))
          return;

        // Clear log file
        ClearLogFile();

        string mp = Settings.Default.MountPoint;
        DokanOptions opt = new DokanOptions()
        {
          VolumeLabel = "XVMfs",
          DebugMode = false,
          MountPoint = Path.GetFullPath(mp),
          ThreadCount = 1,
        };
        Debug("MountPoint: " + opt.MountPoint);

        PrepareMountPoint(opt.MountPoint);

        Debug("Creating server thread");
        Thread thread = new Thread(StartDokan);
        try
        {
          Debug("Starting server thread");
          thread.Start(opt);

          Thread.Sleep(2000);

          if (!thread.IsAlive)
            Debug("Dokan thread is not alive. Exiting.");
          else
          {
            ProcessMainThread(args);
          }
        }
        finally
        {
          Log("Stopping server");

          // Unmount and clean.
          DokanNet.DokanRemoveMountPoint(opt.MountPoint);
          if (thread.IsAlive)
            thread.Join();
          Directory.Delete(opt.MountPoint);
        }
      }
      catch (Exception ex)
      {
        Log(String.Format("{0}{1}{1}Press any key to exit.", ex, Environment.NewLine));
        Console.ReadKey(true);
      }
    }

    static void StartDokan(object opt)
    {
      // Start dokan
      int status;
      try
      {
        Debug("Dokan thread: Starting main loop");
        status = DokanNet.DokanMain(opt as DokanOptions, new Server(serverVersion));
        Debug("Dokan thread: Main loop ended");
      }
      catch (Exception ex)
      {
        Log(ex.ToString());
        return;
      }

      switch (status)
      {
        case DokanNet.DOKAN_DRIVE_LETTER_ERROR:
          Log("Dokan: Bad Drive letter");
          break;
        case DokanNet.DOKAN_DRIVER_INSTALL_ERROR:
          Log("Dokan: Can't install driver");
          break;
        case DokanNet.DOKAN_MOUNT_ERROR:
          Log("Can't assign a drive letter or mount point");
          break;
        case -6: // DOKAN_MOUNT_POINT_ERROR
          Log("Mount point is invalid");
          break;
        case DokanNet.DOKAN_START_ERROR:
          Log("Dokan: Driver something wrong");
          break;
        case DokanNet.DOKAN_ERROR:
          Log("Dokan: General Error");
          break;
        case DokanNet.DOKAN_SUCCESS:
          Log("Dokan: Success");
          break;
        default:
          Log("Unknown status: " + status);
          break;
      }
    }

    static void UnhandledException(object sender, UnhandledExceptionEventArgs e)
    {
      try
      {
        Log("Unhandled exception!\nPlease contact the developers with the following information:\n\n" +
          (Exception)e.ExceptionObject);
      }
      finally
      {
        if (wotProcess != null)
          wotProcess.Kill();
      }
    }

    private static void ProcessMainThread(string[] args)
    {
      if (!isNoAuto)
      {
        Debug("Dokan thread is alive");
        string arg = String.Join(" ", args);
        Log(String.Format("Starting game process: {0} {1}", wotExeFileName, arg));
        try
        {
          ProcessStartInfo startInfo = new ProcessStartInfo(wotExeFileName);
          startInfo.Arguments = arg;
          if (!isLauncher && isMaximized)
            startInfo.WindowStyle = ProcessWindowStyle.Maximized;
          wotProcess = Process.Start(startInfo);
          Debug("Check game process");
          if (wotProcess == null)
            throw new Exception("Cannot start game: " + wotExeFileName);

          // Waiting process info 20 sec
          string processInfo = "";
          for (int i = 0; i < 20; ++i)
          {
            Thread.Sleep(1000);
            try
            {
              processInfo = "wotProcess: \n" + wotProcess.MainModule.FileVersionInfo;
              break;
            }
            catch (Exception ex)
            {
              processInfo = "wotProcess: Error: " + ex;
            }
          }
          Debug(processInfo);

          if (isLauncher)
          {
            Debug("Wait for launcher process to exit");
            wotProcess.WaitForExit();
            wotProcess.Dispose();
            wotProcess = null;
            Log("Searching game process: " + WOT_PROCESS_NAME);
            Thread.Sleep(5000);
            Process[] wotProcesses = Process.GetProcessesByName(WOT_PROCESS_NAME);
            Debug(String.Format("Found {0} process", wotProcesses.Length));
            if (wotProcesses.Length > 0)
              wotProcess = wotProcesses[0];
          }

          if (wotProcess != null)
          {
            // start update stats thread
            UpdateStatThread.Instance.Start();
            
            switch (priority)
              {
                case "realtime":
                  wotProcess.PriorityClass = ProcessPriorityClass.RealTime;
                  break;
                case "high":
                  wotProcess.PriorityClass = ProcessPriorityClass.High;
                  break;
                case "abovenormal":
                  wotProcess.PriorityClass = ProcessPriorityClass.AboveNormal;
                  break;
                case "belownormal":
                  wotProcess.PriorityClass = ProcessPriorityClass.BelowNormal;
                  break;
                case "idle":
                  wotProcess.PriorityClass = ProcessPriorityClass.Idle;
                  break;
                default:
                  wotProcess.PriorityClass = ProcessPriorityClass.Normal;
                  break;
               }
            Debug("Priority set to " + wotProcess.PriorityClass.ToString());
            
            Debug("Wait for game process to exit");
            wotProcess.WaitForExit();
          }
        }
        finally
        {
          if (wotProcess != null)
          {
            wotProcess.Dispose();
            wotProcess = null;
          }
        }
      }
      else
      {
        Log("Please start your game manually within 2 minutes");

        for (int i = 0; i < 20; i++)
        {
          Thread.Sleep(6000);
          Process[] wotProcesses = Process.GetProcessesByName(WOT_PROCESS_NAME);
          if (wotProcesses.Length > 0)
          {
            wotProcess = wotProcesses[0];
            wotProcess.WaitForExit();
            wotProcess.Dispose();
            wotProcess = null;
            break;
          }
        }
      }
    }
  }
}
