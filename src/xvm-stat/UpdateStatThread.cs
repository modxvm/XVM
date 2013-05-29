using System;
using System.Collections.Generic;
using System.Threading;

namespace wot
{
  /// <summary>
  /// UpdateStatThread (потокобезопасный Singleton с использованием с отложенной инициализацией)
  /// </summary>
  public class UpdateStatThread : Singleton<UpdateStatThread>
  {
    #region private ctor()
    private UpdateStatThread()
    {
    }
    #endregion

    private struct UpdateRequest
    {
      public string proxy;
      public string guid;
      public long id;
    }

    private readonly Queue<UpdateRequest> updateQueue = new Queue<UpdateRequest>();
    private Thread thread;

    private class WotServer
    {
      public string name;
      public string host;
      public int port;
      public string api;
      public int timeout;
      public long startId;
      public long endId;

      public WotServer(string name, string host, int port, string api, int timeout, long startId, long endId)
      {
        this.name = name;
        this.host = host;
        this.port = port;
        this.api = api;
        this.timeout = timeout;
        this.startId = startId;
        this.endId = endId;
      }
    }

    private static readonly WotServer[] WotServers = new WotServer[] {
      new WotServer("RU",  "api.worldoftanks.ru", 80, "1.5", 5000, 0, 499999999),
      new WotServer("EU",  "api.worldoftanks.eu", 80, "1.5", 5000, 500000000, 999999999),
      new WotServer("US",  "api.worldoftanks.com", 80, "1.5", 5000, 1000000000, 1499999999),
      new WotServer("SEA", "api.worldoftanks-sea.com", 80, "1.5", 6000, 2000000000, 2499999999),
      new WotServer("VTC", "portal-wot.go.vn", 80, "1.5", 12000, 2500000000, 2999999999),
      new WotServer("KR",  "worldoftanks.kr", 80, "1.5", 6000, 3000000000, 3499999999),
    };

    public void Start()
    {
      thread = new Thread(ThreadFunc);
      thread.IsBackground = true;
      thread.Start();
    }

    /*public void Stop()
    {
      thread.Abort();
    }*/

    public static void Enqueue(string proxy, string guid, long[] ids)
    {
      if (ids == null || ids.Length == 0)
        return;
      lock (Instance.updateQueue)
      {
        foreach (long id in ids)
          Instance.updateQueue.Enqueue(new UpdateRequest() { proxy = proxy, guid = guid, id = id });
      }
    }

    private void ThreadFunc()
    {
      try
      {
        while (true)
        {
          Thread.Sleep(100);
          UpdateRequest request;
          while (true)
          {
            lock (updateQueue)
            {
              if (updateQueue.Count == 0)
                return;
              request = updateQueue.Dequeue();
            }

            if (!string.IsNullOrEmpty(request.guid) && request.id > 0)
            {
              Program.Log("[UPDATE] " + request.id);
              Thread thread = new Thread(UpdateFunc);
              thread.Start(request);
            }
          }
        }
      }
      catch
      {
      }
    }

    private void UpdateFunc(object data)
    {
      UpdateRequest request = (UpdateRequest)data;
      try
      {
        WotServer srv = Array.Find<WotServer>(WotServers, x => request.id >= x.startId && request.id <= x.endId);
        if (srv == null)
          return;
        string url = String.Format("http://{0}:{1}/uc/accounts/{2}/api/{3}/?source_token=Intellect_Soft-WoT_Mobile-unofficial_stats",
          srv.host, srv.port, request.id, srv.api);
        long duration;
        string response = Utils.LoadUrl(url, out duration, true);
        if (duration == long.MaxValue) // error
          return;

        url = request.proxy.Replace("%1", "submitPlayer/") + request.guid;
        Utils.HttpPost(url, response);
      }
      catch
      {
        // do nothing
      }
    }
  }
}
