using Community.CsharpSqlite;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using wot.Properties;

namespace wot.Dossier
{
  public class DossierDB: Singleton<DossierDB>
  {
    #region private ctor()
    private DossierDB()
    {
    }
    #endregion

    private const string VAR_DB_VERSION = "DB_VERSION";
    private const string DB_VERSION = "1";

    #region DB Structure
    private readonly static string[] CREATE_Commands = {
      "CREATE TABLE Vars (key TEXT PRIMARY KEY, value TEXT)",
      "INSERT INTO Vars VALUES ('" + VAR_DB_VERSION + "', '" + DB_VERSION + "')",

      "CREATE TABLE Settings (key TEXT PRIMARY KEY, value TEXT)",

      "CREATE TABLE Players (playerName TEXT PRIMARY KEY, start INT, last INT)",

      "CREATE TABLE DossierCacheFiles (filename TEXT PRIMARY KEY, modified INT, lastBattleTime INT)",

      "CREATE TABLE VehicleInfo (vid INT, vname TEXT, level INT, class INT, premium INT, hp INT, localizedName TEXT, icon TEXT, PRIMARY KEY(vid))",
      "CREATE INDEX idx_VehicleInfo_vname ON VehicleInfo (vname)",

      "CREATE TABLE VehicleStat (playerName TEXT, dt INT, vid INT, data TEXT, company TEXT, clan TEXT, PRIMARY KEY(playerName, dt, vid))",
      "CREATE INDEX idx_VehicleStat_playerName_dt ON VehicleStat (playerName, dt)",

      "CREATE VIEW v_CurrentStat AS SELECT playerName, vid, data, company, clan FROM VehicleStat GROUP BY playerName, vid HAVING dt = MAX(dt)"

      //"CREATE TABLE Summary (playerName TEXT, dt INT, battles INT, wins INT, losses INT, survived INT, xp INT, avgXp INT, maxXp INT, PRIMARY KEY(playerName, dt))",
    };
    #endregion

    private SQLiteDatabase _db = null;

    private SQLiteDatabase db
    {
      get
      {
        if (_db == null)
          _initialize();
        return _db;
      }
    }


    #region initialization

    private readonly static string[] PRAGMA_Commands = {
      "PRAGMA auto_vacuum = INCREMENTAL",
      "PRAGMA incremental_vacuum(1024)",
      "PRAGMA journal_mode = WAL",
      "PRAGMA locking_mode = EXCLUSIVE",
      "PRAGMA synchronous =  NORMAL",
      "PRAGMA temp_store =  MEMORY",
    };

    private void _initialize()
    {
      Directory.CreateDirectory(Path.GetDirectoryName(Settings.Default.XvmDbFileName));
      _db = new SQLiteDatabase(Settings.Default.XvmDbFileName);
      for (int i = 0; i < PRAGMA_Commands.Length; i++)
        db.ExecuteNonQuery(PRAGMA_Commands[i]);
                                                      
      ArrayList tables = db.GetTables();
      if (tables.Count == 0)
        CreateDatabase();
      else
      {
        string ver = GetVar(VAR_DB_VERSION);
        if (ver != DB_VERSION)
          UpgradeDatabase(ver);
      }

      UpdateVehicleInfo();
    }

    private void CreateDatabase()
    {
      for (int i = 0; i < CREATE_Commands.Length; i++)
        db.ExecuteNonQuery(CREATE_Commands[i]);
    }

    private void UpgradeDatabase(string ver)
    { 
      // TODO
    }

    private void UpdateVehicleInfo()
    {
      foreach (VehicleInfoData vd in VehicleInfo.data)
      {
        ExecuteNonQuery(String.Format("INSERT OR REPLACE INTO VehicleInfo VALUES ({0}, {1}, {2}, {3}, {4}, {5}, '', '')",
          vd.vid, Q(vd.vname), vd.level, vd.vclass, vd.premium ? 1 : 0, vd.hp));
      }
    }
    #endregion

    #region quote functions
    public static string q(string str)
    {
      return str.Replace("\"", "\"\"");
    }

    public static string Q(string str)
    {
      return String.Format("\"{0}\"", q(str));
    }
    #endregion

    #region Execute* functions  (private static)

    private readonly static object _executeLock = new object();

    private static void ExecuteNonQuery(string query)
    {
      lock (_executeLock)
        Instance.db.ExecuteNonQuery(query);
    }

    private static DataTable Execute(string query)
    {
      lock (_executeLock)
        return Instance.db.ExecuteQuery(query);
    }

    private static DataRow ExecuteRow(string query)
    {
      DataTable t = Execute(query);
      return t != null && t.Rows.Count > 0 ? t.Rows[0] : null;
    }

    private static String ExecuteScalar(string query)
    {
      DataRow r = ExecuteRow(query);
      return r != null && r.ItemArray.Length > 0 ? r[0].ToString() : null;
    }
    #endregion

    #region GetVar / SetVar (public static)
    public static string GetVar(string var)
    {
      return ExecuteScalar("SELECT value FROM Vars WHERE key=" + Q(var));
    }

    public static void SetVar(string var, string value)
    {
      ExecuteNonQuery(String.Format("INSERT OR REPLACE INTO Vars VALUES ({0}, {1})", Q(var), Q(value)));
    }
    #endregion

    #region LoadSettings / SaveSettings (public static)
    public static string LoadSettings(string key)
    {
      return ExecuteScalar("SELECT value FROM Settings WHERE key=" + Q(key));
    }

    public static void SaveSettings(string key, string value)
    {
      ExecuteNonQuery(String.Format("INSERT OR REPLACE INTO Settings VALUES ({0}, {1})", Q(key), Q(value)));
    }
    #endregion

    public static int GetDossierFileParam(string filename, string paramName, int defaultValue = 0)
    {
      string value = ExecuteScalar(String.Format("SELECT {0} FROM DossierCacheFiles WHERE filename={1}", paramName, Q(filename)));
      if (string.IsNullOrEmpty(value))
        return defaultValue;
      int res;
      return int.TryParse(value, out res) ? res : defaultValue;
    }

    public static void UpdateDossierData(string filename, int modified, DossierData dossier)
    {
      int lastBattleTime = DossierDB.GetDossierFileParam(filename, "lastBattleTime");
      int newLastBattleTime = dossier.maxLastBattleTime;
      ExecuteNonQuery(String.Format("INSERT OR REPLACE INTO DossierCacheFiles VALUES ({0}, {1}, {2})", Q(filename), modified, newLastBattleTime));

      if (newLastBattleTime <= 0)
        return;

      // update periods
      DataRow playerDataRow = ExecuteRow("SELECT 1 FROM Players WHERE playerName=" + Q(dossier.playerName));
      ExecuteNonQuery(playerDataRow == null
        ? String.Format("INSERT INTO Players VALUES({0}, {1}, {1})", Q(dossier.playerName), newLastBattleTime)
        : String.Format("UPDATE Players SET last={1} WHERE playerName={0}", Q(dossier.playerName), newLastBattleTime));

      // update vehicle stat
      if (dossier.vehicles == null)
        return;

      Program.Log("UpdateDossierData: " + dossier.playerName);
      foreach (DossierVehicleData vd in dossier.vehicles)
      {
        if (vd.lastBattleTime <= lastBattleTime)
          continue;

        VehicleInfoData vi = VehicleInfo.ByVid(vd.vid);
        if (vi == null)
        {
          Program.Log("WARNING: no data for vid=" + vd.vid);
          continue;
        }

        Program.Log(String.Format("  {0}: {1} ({2} battles)", vd.lastBattleTime.ToUnixDateTime(), vi.vname, vd.tankdata_battlesCount));

        ExecuteNonQuery(String.Format("INSERT OR REPLACE INTO VehicleStat VALUES ({0}, {1}, {2}, {3}, {4}, {5})",
          Q(dossier.playerName),
          vd.lastBattleTime,
          vd.vid,
          Q(vd.TankDataToJson()),
          Q(vd.CompanyDataToJson()),
          Q(vd.ClanDataToJson())));
      }
    }

    public static DataTable GetDataForTime(string playerName, long time)
    {
      return Execute(String.Format(
        "SELECT {1} AS time, vs.vid, vi.level, vi.class, vi.hp, data, company, clan" +
        " FROM VehicleStat vs" +
        " JOIN VehicleInfo vi ON vs.vid = vi.vid" +
        " WHERE playerName={0} AND dt <= {1} GROUP BY vs.vid HAVING dt = MAX(dt)",
        Q(playerName), time));
    }
  }
}
