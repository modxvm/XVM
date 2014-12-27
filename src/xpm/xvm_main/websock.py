import websocket
import tlslite
import threading
import traceback

import BigWorld
from gui import SystemMessages

from constants import *
from logger import *
import utils

_WEBSOCKETS_ENABLED = False

class _WebSock(object):

    def __init__(self):
        self._ws = None
        self._thread = None
        self._last_error = None
        self.on_open = EventHook()
        self.on_close = EventHook()
        self.on_message = EventHook()
        self.on_error = EventHook()

    @property
    def enabled(self):
        return _WEBSOCKETS_ENABLED

    @property
    def connected(self):
        return self._ws and self._ws.sock

    @property
    def last_error(self):
        return self._last_error

    def start(self, e=None):
        if not _WEBSOCKETS_ENABLED:
            return
        debug('WebSocket: start')
        if self._ws:
            raise Exception('WebSocket: already connected')
        self._start()

    def _start(self):
        self._ws = websocket.WebSocketApp(
            XVM_WS_URL,
            on_open = self._on_open,
            on_message = self._on_message,
            on_error = self._on_error,
            on_close = self._on_close)
        self._thread = threading.Thread(target=self.run)
        self._thread.daemon = True
        self._thread.start()

    def run(self):
        import ssl
        sslopt = {
            'cert_reqs': ssl.CERT_NONE,
            'check_hostname': False,
            'fingerprint': XVM_FINGERPRINT,
            #'fingerprint': '8a95feb7be9825fbe3f4f50a6662dc880764c876', # 'wss://echo.websocket.org/'
            }
        self._ws.run_forever(sslopt=sslopt)

    def stop(self, e=None):
        if not _WEBSOCKETS_ENABLED:
            return
        debug('WebSocket: stop')
        self._stop()

    def _stop(self):
        if self.connected:
            self._ws.on_error = None
            self._ws.close()
        if self._thread:
            #self._thread.join()
            self._thread = None
        self._ws = None

    def restart(self):
        debug('WebSocket: restart')
        self._stop()
        BigWorld.callback(5, self._start)

    def send(self, msg):
        try:
            if self._ws:
                if self.connected:
                    self._ws.send(msg)
                else:
                    log('[WARNING] send(): WebSocket closed')
        except:
            err(traceback.format_exc())

    # PRIVATE

    def _on_open(self, ws):
        debug('WebSocket: opened')
        self.on_open.fire()

    def _on_close(self, ws):
        debug('WebSocket: closed')
        self.on_close.fire()

    def _on_message(self, ws, message):
        #debug('WebSocket recv: %s ' % message)
        self.on_message.fire(message)

    def _on_error(self, ws, error):
        err('WebSocket: error: %s' % str(error))
        self._last_error = error

        if isinstance(error, tlslite.TLSFingerprintError):
            BigWorld.callback(0, self.stop)
        else:
            BigWorld.callback(0, self.restart)

        self.on_error.fire(error)


g_websock = _WebSock()
