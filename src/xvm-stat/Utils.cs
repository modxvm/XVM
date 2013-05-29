using LitJson;
using System;
using System.Diagnostics;
using System.Net;
using wot.Properties;
using System.IO;
using System.Text;

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

    #region JsonData extensions

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

    #region Network

    public static string LoadUrl(string url, string members)
    {
      long dummy;
      return LoadUrl(url, members, out dummy);
    }

    public static string LoadUrl(string url, string members, out long duration, bool test = false)
    {
      if (!test)
        Program.Log("HTTP: " + members);
      url = url.Replace("%1", members).Replace("%2", Program.PublicKeyToken);
      return LoadUrl(url, out duration, false);
    }

    public static string LoadUrl(string url, out long duration, bool quiet = false)
    {
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

      if (!quiet)
      {
        Program.Log(String.Format("  Time: {0} ms, Size: {1} bytes", sw.ElapsedMilliseconds, responseFromServer.Length));
        Program.Debug("responseFromServer: " + responseFromServer);
      }

      // check if error (???)
      if (response.StatusCode == HttpStatusCode.OK || response.StatusCode == HttpStatusCode.Accepted)
      {
        // One of our ratting servers' exception starts with "onException"
        if (!responseFromServer.StartsWith("onException", StringComparison.InvariantCultureIgnoreCase))
          duration = sw.ElapsedMilliseconds;
      }

      return responseFromServer;
    }

    public static void HttpPost(string url, string postData)
    {
      HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
      request.AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate;
      request.Credentials = CredentialCache.DefaultCredentials;
      if (!Program.isNoProxy)
        request.Proxy.Credentials = CredentialCache.DefaultCredentials;
      else
        request.Proxy = new WebProxy();
      request.Timeout = Settings.Default.Timeout;

      byte[] data = Encoding.UTF8.GetBytes(postData);
      request.Method = "POST";
      request.ContentType = "application/x-javascript";
      request.ContentLength = data.Length;
      
      using (Stream stream = request.GetRequestStream())
        stream.Write(data, 0, data.Length);

      request.GetResponse();
    }
    #endregion

  }
}
