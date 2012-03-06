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

    static Program()
    {
      AppDomain.CurrentDomain.AssemblyResolve += Resolver;
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
      Console.WriteLine("Usage: wot-xvm-proxy.exe [/launcher] [/debug] [/server=(RU|EU|NA|CN1|CN2)] [file.wotreplay]");
      Console.WriteLine("  /launcher - run launcher instead of game");
      Console.WriteLine("  /debug - run in debug mode (extended log)");
      Console.WriteLine("  /server=(RU|EU|NA|CN1|CN2) - select server (disable autodetection)");
      Console.WriteLine("  file.wotreplay - play replay");
      Console.WriteLine("Press any key to exit.");
      Console.ReadKey(true);
    }

    private static void Main(string[] args)
    {
      try
      {
        Console.Title = "WoT XVM Proxy v" + Assembly.GetExecutingAssembly().GetName().Version;

        // Check args
        for (int i = 0; i < args.Length; i++)
        {
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
            Console.WriteLine("DEBUG MODE: ON");
            continue;
          }

          if (args[i].StartsWith("/server=", StringComparison.InvariantCultureIgnoreCase))
          {
            serverVersion = args[i].Substring(8);
            args[i] = "";
            continue;
          }

          if (File.Exists(args[i]))
            args[i] = String.Format(@"""{0}""", args[i]);
        }

        Directory.SetCurrentDirectory(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location));

        // Check game start file exists
        if (!File.Exists(wotExeFileName))
          throw new Exception("Game start file not found: " + wotExeFileName);

        string mp = Settings.Default.MountPoint;
        if (Directory.Exists("res_mods"))
          mp = String.Format("res_mods{0}{1}", Path.DirectorySeparatorChar, mp);
        DokanOptions opt = new DokanOptions()
        {
          DebugMode = true,
          MountPoint = Path.GetFullPath(mp),
          ThreadCount = 5
        };

        // Unmount MountPoint if left from previous start.
        try
        {
          DokanNet.DokanRemoveMountPoint(opt.MountPoint);
        }
        catch
        {
          // nothing
        }

        // Create MountPoint directory.
        DirectoryInfo di = new DirectoryInfo(opt.MountPoint);
        if (di.Exists)
        {
          // try to delete old Dokan link.
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

        Thread thread = new Thread(StartDokan);
        try
        {
          thread.Start(opt);

          Thread.Sleep(1000);

          if (thread.IsAlive)
          {
            string arg = String.Join(" ", args);
            Console.WriteLine(String.Format("Starting game process: {0} {1}", wotExeFileName, arg));
            using (Process wotProc = Process.Start(wotExeFileName, arg))
            {
              if (wotProc == null)
                throw new Exception("Cannot start game: " + wotExeFileName);
              wotProc.WaitForExit();
              if (isLauncher && wotProc.ExitCode == 0)
              {
                Console.WriteLine("Searching game process: " + WOT_PROCESS_NAME);
                Thread.Sleep(5000);
                Process[] wotProcesses = Process.GetProcessesByName(WOT_PROCESS_NAME);
                if (wotProcesses.Length > 0)
                  wotProcesses[0].WaitForExit();
              }
            }
          }
        }
        finally
        {
          Console.WriteLine("Stopping server");

          // Unmount and clean.
          DokanNet.DokanRemoveMountPoint(opt.MountPoint);
          if (thread.IsAlive)
            thread.Join();
          Directory.Delete(opt.MountPoint);
        }
      }
      catch (Exception ex)
      {
        Console.WriteLine(String.Format("{0}{1}{1}Press any key to exit.", ex, Environment.NewLine));
        Console.ReadKey(true);
        return;
      }
    }

    static void StartDokan(object opt)
    {
      // Start dokan
      int status = DokanNet.DokanMain(opt as DokanOptions, new Server(serverVersion));

      switch (status)
      {
        case DokanNet.DOKAN_DRIVE_LETTER_ERROR:
          Console.WriteLine("Dokan: Bad Drive letter");
          break;
        case DokanNet.DOKAN_DRIVER_INSTALL_ERROR:
          Console.WriteLine("Dokan: Can't install driver");
          break;
        case DokanNet.DOKAN_MOUNT_ERROR:
          Console.WriteLine("Can't assign a drive letter or mount point");
          break;
        case -6: // DOKAN_MOUNT_POINT_ERROR
          Console.WriteLine("Mount point is invalid");
          break;
        case DokanNet.DOKAN_START_ERROR:
          Console.WriteLine("Dokan: Driver something wrong");
          break;
        case DokanNet.DOKAN_ERROR:
          Console.WriteLine("Dokan: General Error");
          break;
        case DokanNet.DOKAN_SUCCESS:
          Console.WriteLine("Dokan: Success");
          break;
        default:
          Console.WriteLine("Unknown status: {0}", status);
          break;
      }
    }
  }
}
