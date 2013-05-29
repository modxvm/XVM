using System;
using System.IO;

namespace wot
{
  public class Logger : Singleton<Logger>, IDisposable
  {
    public static string Path
    {
      set
      {
        Instance._w = new StreamWriter(value, false);
      }
    }

    public static bool IsActive
    {
      get
      {
        return Instance._w != null;
      }
    }

    #region private ctor()
    private Logger()
    {
    }
    #endregion

    private bool _disposed;
    private TextWriter _w;
    private readonly object _lock = new object();

    ~Logger()
    {
      Dispose(false);
    }

    #region public

    public static void LogAsync(string message)
    {
      if (!Logger.IsActive)
        return;
      Action<string> action = Instance.WriteMessage;
      action.BeginInvoke(message, WriteMessageComplete, action);
    }

    public static void Log(string message)
    {
      if (!Logger.IsActive)
        return;
      Instance.WriteMessage(message);
    }

    #endregion

    #region private

    private static void WriteMessageComplete(IAsyncResult iar)
    {
      ((Action<string>)iar.AsyncState).EndInvoke(iar);
    }

    private void WriteMessage(string message)
    {
      lock (_lock)
      {
        if (!_disposed && (_w != null))
        {
          _w.Write(message);
          _w.Flush();
        }
      }
    }

    #endregion

    #region IDisposable

    public void Dispose()
    {
      Dispose(true);
      GC.SuppressFinalize(this);
    }

    private void Dispose(bool disposing)
    {

      lock (_lock)
      {
        if (_disposed)
        {
          return;
        }

        if (disposing)
        {
          if (_w != null)
          {
            _w.Dispose();
            _w = null;
          }
        }

        _disposed = true;
      }
    }

    #endregion
  }
}
