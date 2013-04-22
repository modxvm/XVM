using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Xml;
using LitJson;
using wot.BxmlDecoder;
using System.Net.NetworkInformation;
using System.Net;

namespace wot
{
  /// <summary>
  /// PingWotServers (потокобезопасный Singleton с использованием с отложенной инициализацией)
  /// </summary>
  public class PingWotServers : Singleton<PingWotServers>
  {
    #region private ctor()
    private PingWotServers()
    {
    }
    #endregion

    private Dictionary<string, string> servers = null;

    private string pingResult = "";
    private readonly object pingResultLock = new object();

    private readonly Ping ping = new Ping();

    public string Ping()
    {
      if (servers == null)
      {
        servers = new Dictionary<string, string>();

        //<scripts_config.xml>
        //  <login>
        //    <host>
        //      <name>WOT RU1</name>
        //      <url>login.p1.worldoftanks.net:20014</url>
        //      <public_key_path>loginapp_wot.pubkey</public_key_path>
        //      <periphery_id>	1	</periphery_id>
        //    </host>
        //    ...
        //  </login>
        //</scripts_config.xml>
        BxmlReader reader = new BxmlReader("res\\scripts_config.xml");
        XmlNode root = reader.getFile().DocumentElement;
        XmlNodeList hosts = root.SelectSingleNode("//login").ChildNodes;
        foreach (XmlNode node in hosts)
        {
          if (node.Name != "host")
            continue;
          servers[node.SelectSingleNode("name").InnerText] = node.SelectSingleNode("url").InnerText;
        }
      }

      if (servers.Count == 0)
        throw new Exception("No WoT servers found");

      Thread thread = new Thread(PingAsync);
      thread.Start();

      return pingResult;
    }

    private void PingAsync()
    {
      try
      {
        Dictionary<string, string> res = new Dictionary<string, string>();
        foreach (string name in servers.Keys)
        {
          PingReply pingReply = ping.Send(servers[name].Split(':')[0]);
          res[name] = pingReply.Status == IPStatus.Success ? pingReply.RoundtripTime.ToString() : pingReply.Status.ToString();
        }
        lock (pingResultLock)
          pingResult = JsonMapper.ToJson(res);
      }
      catch (Exception ex)
      {
        pingResult = "PING ERROR: " + ex;
      }
    }
  }
}
