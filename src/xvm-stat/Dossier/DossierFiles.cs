using Razorvine.Pickle;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;

namespace wot.Dossier
{
  public class DossierFiles: Singleton<DossierFiles>
  {
    // TODO: Use FAM?
    private const int FILE_SCAN_INTERVAL = 5000; // msec

    #region private ctor()
    private DossierFiles()
    {
    }
    #endregion

    public void initialize()
    {
      Thread thread = new Thread(DossierFilesMonitor);
      thread.IsBackground = true;
      thread.Start();
    }
    //UpdateDossierFilesData

    private void DossierFilesMonitor()
    {
      string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/Wargaming.net/WorldOfTanks/dossier_cache";

      int counter = FILE_SCAN_INTERVAL;
      try
      {
        while (true)
        {
          Thread.Sleep(100);
          counter += 100;
          if (counter < FILE_SCAN_INTERVAL)
            continue;
          counter = 0;

          string[] files = Directory.GetFiles(path, "*.dat", SearchOption.TopDirectoryOnly);
          foreach (string file in files)
          {
            FileInfo fi = new FileInfo(file);
            if (fi.Extension.ToLower() != ".dat")
              continue;

            int dbTime = DossierDB.GetDossierFileParam(fi.Name, "modified");
            int time = fi.LastWriteTimeUtc.ToUnixTime();

            if (time != dbTime)
              UpdateDossierFile(fi);
          }
        }
      }
      catch (Exception ex)
      {
        Program.Log("DossierFiles ERROR: " + ex);
      }
    }

    private void UpdateDossierFile(FileInfo fi)
    {
      using (Unpickler unpickler = new Unpickler())
      {
        using (FileStream fs = fi.OpenRead())
        {
          DossierData dossier = ParseDossierRawData(fi.Name, unpickler.load(fs));
          DossierDB.UpdateDossierData(fi.Name, fi.LastWriteTimeUtc.ToUnixTime(), dossier);
        }
      }
    }

    private DossierData ParseDossierRawData(string filename, object raw)
    {
      try
      {
        DossierData dossier = new DossierData();

        dossier.dossierVersion = (int)((raw as object[])[0]);

        //if (dossier.dossierVersion != 16)
        //    throw new Exception("Unsupported dossier cache version: " + dossier.dossierVersion + "\n" + filename);

        string[] base32name = Encoding.ASCII.GetString(Utils.FromBase32String(Path.GetFileNameWithoutExtension(filename))).Split(new char[] { ';' }, 2);
        dossier.server = base32name[0];
        dossier.playerName = base32name[1];

        Hashtable vehicleitems = (raw as object[])[1] as Hashtable;
        foreach (DictionaryEntry item in vehicleitems)
        {
          DossierVehicleData vd = new DossierVehicleData();
          vd.vid = (int)((item.Key as object[])[1]) & 0xFFFFF0;
          byte[] data = (item.Value as object[])[1] as byte[];
          if (data == null || data.Length == 0)
            continue;
          byte vehicleVersion = data[0];
          switch (vehicleVersion)
          {
            case 20:
              vd.AppendStruct(Utils.ReadStruct<VehicleData_20>(data));
              break;

            case 22:
              vd.AppendStruct(Utils.ReadStruct<VehicleData_22>(data));
              break;

            case 24:
              vd.AppendStruct(Utils.ReadStruct<VehicleData_24>(data));
              break;

            case 26:
              vd.AppendStruct(Utils.ReadStruct<VehicleData_26>(data));
              break;

            case 27:
              vd.AppendStruct(Utils.ReadStruct<VehicleData_27>(data));
              break;

            case 28:
              vd.AppendStruct(Utils.ReadStruct<VehicleData_28>(data));
              break;

            default:
              throw new Exception("Unsupported dossier cache vehicle version: " + vehicleVersion);
          }
          if (dossier.vehicles == null)
            dossier.vehicles = new List<DossierVehicleData>();
          dossier.vehicles.Add(vd);
        }


        return dossier;
      }
      catch (Exception ex)
      {
        throw new Exception("", ex);
      }
    }
  }
}
