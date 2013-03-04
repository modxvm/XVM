using LitJson;
using System;

namespace wot
{
  public static class Utils
  {
    public static string GetNormalizedPlayerName(this string fullplayername)
    {
      return fullplayername.Split('[')[0].Trim().ToUpper();
    }

    public static string GetClanName(this string fullplayername)
    {
      if (!fullplayername.Contains("["))
        return "";
      return fullplayername.Split('[', ']')[1].Trim().ToUpper();
    }

    #region JsonData parsers

    public static int ToInt(this JsonData data, params String[] path)
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

    public static long ToLong(this JsonData data, params String[] path)
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

    public static double ToDouble(this JsonData data, params String[] path)
    {
      try
      {
        for (int i = 0; i < path.Length - 1; ++i)
          data = data[path[i]];
        return (data[path[path.Length - 1]].IsDouble || data[path[path.Length - 1]].IsInt) ?
          double.Parse(data[path[path.Length - 1]].ToString()) : 0;
      }
      catch
      {
        return 0;
      }
    }

    public static string ToString(this JsonData data, params String[] path)
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

    #endregion

  }
}
