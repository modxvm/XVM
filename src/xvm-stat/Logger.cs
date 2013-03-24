using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;

namespace wot {
    public class Logger : IDisposable {
        private bool _disposed;
        private TextWriter _w;
        private object _lock;

        public Logger(string path) {
            _w = new StreamWriter(path, false);
            _lock = new {};
        }

        ~Logger() {
            Dispose(false);            
        }


        public void LogAsync(string message) {
            Action<string> action = WriteMessage;
            action.BeginInvoke(message, WriteMessageComplete, action);
        }

        public void Log(string message) {
            WriteMessage(message);
        }


        private static void WriteMessageComplete(IAsyncResult iar) {
            ((Action<string>)iar.AsyncState).EndInvoke(iar);
        }

        private void WriteMessage(string message) {
            lock (_lock) {
                if (!_disposed && (_w != null)) {
                    _w.Write(message);
                }
            }
        }

        public void Dispose() {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing) {

            lock (_lock) {
                if (_disposed) {
                    return;
                }

                if (disposing) {
                    if (_w != null) {
                        _w.Dispose();
                        _w = null;
                    }                  
                }

                _disposed = true;
            }                        
        }
    }
}
