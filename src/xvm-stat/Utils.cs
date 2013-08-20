using LitJson;
using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using wot.Properties;

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
        JsonData jd = data[path[path.Length - 1]];
        return jd.IsInt ? int.Parse(jd.ToString()) : 0;
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
        JsonData jd = data[path[path.Length - 1]];
        return (jd.IsInt || jd.IsLong)
            ? long.Parse(jd.ToString()) : 0;
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
        JsonData jd = data[path[path.Length - 1]];
        return (jd.IsDouble || jd.IsInt || jd.IsLong) ?
          double.Parse(jd.ToString()) : 0;
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
        return data[path[path.Length - 1]].ToString();
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

      //HACK: mkbundle conflicts with WG.net old zlib library.
      if (Program.isMkbundle) 
        request.AutomaticDecompression = DecompressionMethods.None;
      else
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

    #region Base32 decoder

    /// <summary>
    /// Converts a Base32-k string into an array of bytes.
    /// </summary>
    /// <exception cref="System.ArgumentException">
    /// Input string <paramref name="s">s</paramref> contains invalid Base32-k characters.
    /// </exception>
    public static byte[] FromBase32String(string input)
    {
        if (string.IsNullOrEmpty(input))
            throw new ArgumentNullException("input");

        input = input.TrimEnd('='); //remove padding characters
        int byteCount = input.Length * 5 / 8; //this must be TRUNCATED
        byte[] returnArray = new byte[byteCount];

        byte curByte = 0, bitsRemaining = 8;
        int mask = 0, arrayIndex = 0;

        foreach (char c in input)
        {
            int cValue = CharToValue(c);

            if (bitsRemaining > 5)
            {
                mask = cValue << (bitsRemaining - 5);
                curByte = (byte)(curByte | mask);
                bitsRemaining -= 5;
            }
            else
            {
                mask = cValue >> (5 - bitsRemaining);
                curByte = (byte)(curByte | mask);
                returnArray[arrayIndex++] = curByte;
                curByte = (byte)(cValue << (3 + bitsRemaining));
                bitsRemaining += 3;
            }
        }

        //if we didn't end with a full byte
        if (arrayIndex != byteCount)
            returnArray[arrayIndex] = curByte;

        return returnArray;
    }

    private static int CharToValue(char c)
    {
        int value = (int)c;
        //65-90 == uppercase letters
        if (value < 91 && value > 64)
            return value - 65;
        //50-55 == numbers 2-7
        if (value < 56 && value > 49)
            return value - 24;
        //97-122 == lowercase letters
        if (value < 123 && value > 96)
            return value - 97;
        throw new ArgumentException("Character is not a Base32 character.", "c");
    }
    #endregion

    public static T ReadStruct<T>(byte[] data)
    {
      GCHandle handle = GCHandle.Alloc(data, GCHandleType.Pinned);
      T temp = (T)Marshal.PtrToStructure(handle.AddrOfPinnedObject(), typeof(T));
      handle.Free();
      return temp;
    }

    public static string GetResourceAsString(string resourceName)
    {
      var assembly = Assembly.GetExecutingAssembly();
      
      using (Stream stream = assembly.GetManifestResourceStream(resourceName))
      {
        using (StreamReader reader = new StreamReader(stream))
          return reader.ReadToEnd();
      }
    }

    public static byte[] GetResourceAsBytes(string resourceName)
    {
      var assembly = Assembly.GetExecutingAssembly();

      using (Stream stream = assembly.GetManifestResourceStream(resourceName))
      {
        using (BinaryReader reader = new BinaryReader(stream))
          return reader.ReadBytes((int)(stream.Length));
      }
    }

    public static int ToUnixTime(this DateTime date)
    {
      DateTime origin = new DateTime(1970, 1, 1, 0, 0, 0, 0);
      return Convert.ToInt32((date - origin).TotalSeconds);
    }

    public static DateTime ToUnixDateTime(this int timestamp)
    {
      DateTime origin = new DateTime(1970, 1, 1, 0, 0, 0, 0);
      return origin.AddSeconds(timestamp);
    }
  }
}
