using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Threading;
using Dokan;
using wot.Properties;

namespace wot
{
  class Program
  {
    private const string WOT_PROCESS_NAME = "WorldOfTanks";
    private const string WOT_EXE_FILE_NAME = WOT_PROCESS_NAME + ".exe";

    private static string wotExeFileName = WOT_EXE_FILE_NAME;
    private static bool isLauncher = false;
    public static bool isDebug = false;

    public static string serverVersion = null;
    private static bool isNoAuto = false;
    public static bool isNoProxy = false;

    private static Process wotProcess = null;

    private static bool logFileInitialized = false;

    static Program()
    {
      AppDomain.CurrentDomain.AssemblyResolve += Resolver;
      AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(UnhandledException);
    }

    static Assembly Resolver(object sender, ResolveEventArgs args)
    {
      Assembly a1 = Assembly.GetExecutingAssembly();
      string resName = "";
      if (args.Name.StartsWith("DokanNet"))
        resName = "wot.DokanNet.dll";
      Stream s = a1.GetManifestResourceStream(resName);
      byte[] block = new byte[s.Length];
      s.Read(block, 0, block.Length);
      Assembly a2 = Assembly.Load(block);
      return a2;
    }

    private static void Usage()
    {
      Log("Usage: wot-xvm-proxy.exe [/launcher] [/debug] [/server=(RU|EU|NA|CN|SEA|VTC|CT)] [file.wotreplay]");
      Log("  /launcher - run launcher instead of game");
      Log("  /noauto - do not run game automatically");
      Log("  /noproxy - do not use IE proxy settings");
      Log("  /debug - run in debug mode (extended log)");
      Log("  /server=(RU|EU|NA|CN|SEA|VTC|CT) - select server (disable autodetection)");
      Log("  file.wotreplay - play replay");
      Log("Press any key to exit.");
      Console.ReadKey(true);
    }

    private static object _logLock = new object();
    public static void Log(string message, bool debug = false)
    {
      if (!debug || isDebug)
      Console.WriteLine((debug ? "DEBUG: " : "") + message);
      if (!logFileInitialized)
        return;
      lock (_logLock)
      {
        try
        {
          string timestamp = DateTime.Now.ToString("yyyy.MM.dd HH:mm:ss");
          string prefix = debug ? "[D]" : "[i]";
          string logstr = String.Format("{0} {1} ", timestamp, prefix);

          string[] lines = message.Split(new string[] { "\r", "\n" }, StringSplitOptions.RemoveEmptyEntries);
          for (int i = 1; i < lines.Length; i++)
            lines[i] = lines[i].PadLeft(lines[i].Length + logstr.Length);
          logstr += string.Join(Environment.NewLine, lines);
          
          File.AppendAllText("XVM.log", logstr + Environment.NewLine);
        }
        catch
        {
          // do nothing
        }
      }
    }

    public static void Debug(string message)
    {
      Log(message, true);
    }

    private static void Main(string[] args)
    {
      try
      {
        Console.Title = "WoT XVM Proxy v" + Assembly.GetExecutingAssembly().GetName().Version;
        Log(Console.Title);

        // Check args
        Debug("Processing command line arguments: " + String.Join(" ", args));
        for (int i = 0; i < args.Length; i++)
        {
          Debug(String.Format("  {0}: {1}", i, args[i]));
          if (String.Compare(args[i], "/?", true) == 0 || String.Compare(args[i], "/help", true) == 0)
          {
            Usage();
            return;
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

          if (File.Exists(args[i]))
            args[i] = String.Format(@"""{0}""", args[i]);
        }

        // CD to game dir
        string game_dir = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
        Debug("Change dir: " + game_dir);
        Directory.SetCurrentDirectory(game_dir);

        // Check for another instance started
        bool ok;
        Mutex m = new Mutex(true, "wot-xvm-proxy", out ok);
        if (!ok)
          throw new Exception("Another proxy instance is already running.");
        GC.KeepAlive(m);

        // Check game start file exists
        Debug("Check start file exists: " + wotExeFileName);
        if (!File.Exists(wotExeFileName))
          throw new Exception("Game start file not found: " + wotExeFileName);

        // Clear log file
        try
        {
          File.WriteAllText("XVM.log", DateTime.Now.ToString("yyyy.MM.dd HH:mm:ss") + " " +
            Console.Title + Environment.NewLine);
          logFileInitialized = true;
        }
        catch
        {
          // do nothing
        }

        string mp = Settings.Default.MountPoint;
        if (Directory.Exists("res_mods"))
          mp = String.Format("res_mods{0}{1}", Path.DirectorySeparatorChar, mp);
        DokanOptions opt = new DokanOptions()
        {
          DebugMode = true,
          MountPoint = Path.GetFullPath(mp),
          ThreadCount = 5,
        };
        Debug("MountPoint: " + opt.MountPoint);

        // Unmount MountPoint if left from previous start.
        Debug("Unmount previous mount");
        try
        {
          DokanNet.DokanRemoveMountPoint(opt.MountPoint);
        }
        catch
        {
          // nothing
        }

        // Create MountPoint directory.
        Debug("Create MountPoint directory");
        DirectoryInfo di = new DirectoryInfo(opt.MountPoint);
        if (di.Exists)
        {
          // try to delete old Dokan link.
          Debug("try to delete old Dokan link");
          FileAttributes fa = File.GetAttributes(opt.MountPoint);
          if ((fa & FileAttributes.ReparsePoint) != 0)
          {
            try
            {
              Directory.Delete(opt.MountPoint, false);
            }
            catch (Exception ex)
            {
              throw new Exception(String.Format("Cannot delete MountPoint file: {0}{1}{2}",
                opt.MountPoint, Environment.NewLine, ex));
            }
            try
            {
              Directory.CreateDirectory(opt.MountPoint);
            }
            catch (Exception ex)
            {
              throw new Exception(String.Format("Cannot create MountPoint directory: {0}{1}{2}",
                opt.MountPoint, Environment.NewLine, ex));
            }
          }
          else
          {
            if (di.GetFileSystemInfos().Length != 0)
              throw new Exception("MountPoint directory exists and is not empty: " + opt.MountPoint);
          }
        }
        else
        {
          try
          {
            Directory.CreateDirectory(opt.MountPoint);
          }
          catch (Exception ex)
          {
            throw new Exception(String.Format("Cannot create MountPoint directory: {0}{1}{2}",
              opt.MountPoint, Environment.NewLine, ex));
          }
        }

        Debug("Creating server thread");
        Thread thread = new Thread(StartDokan);
        try
        {
          Debug("Starting server thread");
          thread.Start(opt);

          Thread.Sleep(1000);

          if (!thread.IsAlive)
            Debug("Dokan thread is not alive. Exiting.");
          else
          {
            if (!isNoAuto)
            {
              Debug("Dokan thread is alive");
              string arg = String.Join(" ", args);
              Log(String.Format("Starting game process: {0} {1}", wotExeFileName, arg));
              try
              {
                wotProcess = Process.Start(wotExeFileName, arg);
                Debug("Check game process");
                if (wotProcess == null)
                  throw new Exception("Cannot start game: " + wotExeFileName);
                Thread.Sleep(5000);
                Debug("Wait for process to exit");
                wotProcess.WaitForExit();
                if (isLauncher && wotProcess.ExitCode == 0)
                {
                  wotProcess.Dispose();
                  wotProcess = null;
                  Log("Searching game process: " + WOT_PROCESS_NAME);
                  Thread.Sleep(5000);
                  Process[] wotProcesses = Process.GetProcessesByName(WOT_PROCESS_NAME);
                  Debug(String.Format("Found {0} process", wotProcesses.Length));
                  if (wotProcesses.Length > 0)
                  {
                    Debug("Wait for process to exit");
                    wotProcess = wotProcesses[0];
                    wotProcess.WaitForExit();
                  }
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
        finally
        {
          Log("Stopping server");

          // Unmount and clean.
          DokanNet.DokanRemoveMountPoint(opt.MountPoint);
          if (thread.IsAlive)
            thread.Join();
          Directory.Delete(opt.MountPoint);
        }

        if (isDebug)
        {
          Log("Press any key to exit.");
          Console.ReadKey(true);
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
  }
}
