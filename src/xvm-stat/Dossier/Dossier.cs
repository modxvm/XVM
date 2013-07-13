using LitJson;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading;
using System.Data;
using System.Linq.Dynamic;

namespace wot.Dossier
{
  /// <summary>
  /// Dossier (потокобезопасный Singleton с использованием с отложенной инициализацией)
  /// </summary>
  public class Dossier : Singleton<Dossier>
  {
    #region private ctor()
    private Dossier()
    {
    }
    #endregion

    private bool initialized = false;

    private string dossierResult = "";
    private readonly object dossierLock = new object();
    private readonly object dossierResultLock = new object();

    // Entry Point
    public string GetDossierInfo(string parameters)
    {
      lock (dossierLock)
      {
        if (!initialized)
        {
          initialize();
          initialized = true;
        }

        Thread thread = new Thread(ReadDossierInfoAsync);
        thread.Start(parameters);

        lock (dossierResultLock)
          return dossierResult;
      }
    }

    private void initialize()
    {
      DossierFiles.Instance.initialize();
    }

    /// <summary>
    /// Format: playerName;end;interval;count;group_type;data_fields;company_fields;clan_fields
    /// </summary>
    /// <param name="parameter"></param>
    private void ReadDossierInfoAsync(object parameter)
    {
      string res = null;
      try
      {
        string[] parameters = (parameter as string).Split(';');
        string playerName = parameters[1];
        long end = long.Parse(parameters[2]);
        int interval = int.Parse(parameters[3]);
        int count = int.Parse(parameters[4]);
        int groupType = int.Parse(parameters[5]);
        string[] dataFields = ((string)parameters[6]).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        string[] companyFields = ((string)parameters[7]).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        string[] clanFields = ((string)parameters[8]).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

        //Program.Log("ReadDossierInfoAsync");

        DataTable table = null;
        for (int i = 0; i < count; ++i)
        {
          long time = end - (interval * i);
          DataTable t = DossierDB.GetDataForTime(playerName, time);
          if (table == null)
            table = t;
          else
            table.Merge(t);
        }
        res = SerializeDossierResult(table, groupType, dataFields, companyFields, clanFields);
      }
      catch (Exception ex)
      {
        res = "[ERROR] " + ex;
      }
      lock (dossierResultLock)
        dossierResult = res;
      //Program.Log(dossierResult);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="dr"></param>
    /// <param name="groupType">1 - vehicle, 2 - summary, 3 - class, 4 - level</param>
    /// <param name="dataFields"></param>
    /// <param name="companyFields"></param>
    /// <param name="clanFields"></param>
    /// <returns>
    ///   Serialized data
    ///   Format:
    ///     error:
    ///       [ERROR] {error string}
    ///
    ///     groupType = 1 (vehicle)
    ///       CSV: period;vid;fld1;fld2;fld3...
    /// 
    ///     groupType = 2 (summary)
    ///       CSV: period;0;fld1;fld2;fld3...
    /// 
    ///     groupType = 3 (class)
    ///       CSV: period;class;fld1;fld2;fld3...
    /// 
    ///     groupType = 4 (level)
    ///       CSV: period;level;fld1;fld2;fld3...
    /// 
    /// </returns>
    public static string SerializeDossierResult(DataTable table, int groupType, string[] dataFields, string[] companyFields, string[] clanFields)
    {
      if (table == null || table.Rows.Count == 0)
        return "";

      List<string> dataColumns = new List<string>();
      dataColumns.AddRange(AddDataColumns(table.Rows[0], "data", dataFields));
      dataColumns.AddRange(AddDataColumns(table.Rows[0], "company", companyFields));
      dataColumns.AddRange(AddDataColumns(table.Rows[0], "clan", clanFields));

      foreach (DataRow row in table.Rows)
      {
        ExpandFieldsValues(row, "data", dataFields);
        ExpandFieldsValues(row, "company", companyFields);
        ExpandFieldsValues(row, "clan", clanFields);
      }

      Func<DataRow, object> groupFunc = null;
      switch (groupType)
      {
        // Vehicle
        case 1:
          groupFunc = c => String.Format("{0};{1}", c["time"], c["vid"]);
          break;

        // Summary
        case 2:
          groupFunc = c => String.Format("{0};0", c["time"]);
          break;

        // Class
        case 3:
          groupFunc = c => String.Format("{0};{1}", c["time"], c["level"]);
          break;

        // Level
        case 4:
          groupFunc = c => String.Format("{0};{1}", c["time"], c["class"]);
          break;

        default:
          throw new NotImplementedException("Group type not implemented: " + groupType);
      }

      string select_data = "";
      foreach (string col in dataColumns)
        select_data += String.Format(", Sum(Convert.ToDouble(it[\"{0}\"].ToString())) as {0}", col);

      IQueryable result =
        table.AsEnumerable().
        GroupBy(groupFunc).AsQueryable().
        Select(String.Format("New(Key.ToString() as key{0})", select_data));

      string res = "";
      foreach (DynamicClass row in result)
      {
        List<string> r = new List<string>();
        r.Add(row["key"].ToString());
        foreach (string col in dataColumns)
          r.Add(row[col].ToString());
        res += string.Join(";", r.ToArray()) + "\n";
      }

      return res;
    }

    private static string[] AddDataColumns(DataRow row, string dataField, string[] fields)
    {
      List<string> dataColumns = new List<string>();
      
      JsonData jdata = JsonMapper.ToObject(row[dataField].ToString());
      foreach (string fld in fields)
      {
        string fn = String.Format("{0}_{1}", dataField, fld);
        JsonData jd = jdata[fld];
        if (jd == null)
          throw new NoNullAllowedException(fn);

        dataColumns.Add(fn);

        if (jd.IsInt || jd.IsLong || jd.IsDouble)
        {
          if (!row.Table.Columns.Contains(fn))
            row.Table.Columns.Add(fn, typeof(double));
        }
        else
        {
          if (!row.Table.Columns.Contains(fn))
            row.Table.Columns.Add(fn, typeof(string));
        }
      }

      return dataColumns.ToArray();
    }

    private static void ExpandFieldsValues(DataRow row, string dataField, string[] fields)
    {
      if (fields == null || fields.Length == 0)
        return;

      JsonData jdata = JsonMapper.ToObject(row[dataField].ToString());
      foreach (string fld in fields)
      {
        string fn = String.Format("{0}_{1}", dataField, fld);
        JsonData jd = jdata[fld];
        if (jd == null)
          throw new NoNullAllowedException(fn);

        if (jd.IsInt || jd.IsLong || jd.IsDouble)
          row[fn] = double.Parse(jd.ToString());
        else
          row[fn] = jd.ToString();
      }
    }
  }
}
