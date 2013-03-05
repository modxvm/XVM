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
    public static string PublicKeyToken = String.Empty;

    private const string WOT_PROCESS_NAME = "WorldOfTanks";
    private const string WOT_EXE_FILE_NAME = WOT_PROCESS_NAME + ".exe";

    private static string wotExeFileName = WOT_EXE_FILE_NAME;
    private static bool isLauncher = false;
    public static bool isDebug = false;

    public static string serverVersion = null;
    private static bool isNoAuto = false;
    public static bool isNoProxy = false;
    public static bool isMaximized = false;

    private static Process wotProcess = null;

    private static bool logFileInitialized = false;

    static Program()
    {
      AppDomain.CurrentDomain.UnhandledException += UnhandledException;
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
      Log("  file.wotreplay - play replay");
      Log("Press any key to exit.");
      Console.ReadKey(true);
    }

    private readonly static object _logLock = new object();
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
        File.WriteAllText("XVM.log", String.Format(
          "{0:yyyy.MM.dd HH:mm:ss} {1}{2}", DateTime.Now, Console.Title, Environment.NewLine));
        logFileInitialized = true;
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
        if (!CheckArgs(args))
          return;

        // CD to game dir
        string game_dir = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
        Debug("Change dir: " + game_dir);
        Directory.SetCurrentDirectory(game_dir);

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

          Thread.Sleep(1000);
          try
          {
            Debug("wotProcess: \n" + wotProcess.MainModule.FileVersionInfo);
          }
          catch (Exception ex)
          {
            Debug("wotProcess: Error: " + ex);
          }

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
}
