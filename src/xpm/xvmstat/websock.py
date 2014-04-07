import websocket
import threading
import traceback

from gui import SystemMessages

from constants import *
from logger import *

class _WebSock(object):

    def __init__(self):
        self._ws = None
        self._thread = None

    def init(self, e=None):
        self.stop(e)
        self.start(e)

    def start(self, e=None):
        debug('start')
        if not self._ws:
            self._ws = websocket.WebSocketApp(
                XVM_WS_URL,
                on_open = self._on_open,
                on_message = self._on_message,
                on_error = self._on_error,
                on_close = self._on_close)
            self._thread = threading.Thread(target=self._ws.run_forever)
            self._thread.daemon = True
            self._thread.start()

    def stop(self, e=None):
        debug('stop')
        if self._ws:
            self._ws.on_error = None
            self._ws.close()
        if self._thread:
            self._thread.join()
            self._thread = None
        self._ws = None

    # PRIVATE

    def _on_open(self, ws):
        msg = '<a href="#XVM_SITE#">www.modxvm.com</a>\n\nWebSocket opened'
        type = SystemMessages.SM_TYPE.Information
        #SystemMessages.pushMessage(msg, type)
        log('WebSocket opened')

    def _on_close(self, ws):
        #msg = '<a href="#XVM_SITE#">www.modxvm.com</a>\n\nWebSocket closed'
        #type = SystemMessages.SM_TYPE.Information
        #SystemMessages.pushMessage(msg, type)
        log('WebSocket closed')

    def _on_message(self, ws, message):
        msg = '<a href="#XVM_SITE#">www.modxvm.com</a>\n\n&gt; ' + message
        type = SystemMessages.SM_TYPE.Information
        #SystemMessages.pushMessage(msg, type)
        log('WebSocket recv: ' + message)

    def _on_error(self, ws, error):
        msg = '<a href="#XVM_SITE#">www.modxvm.com</a>\n\nError: ' + str(error)
        type = SystemMessages.SM_TYPE.Error
        #SystemMessages.pushMessage(msg, type)
        err('WebSocket err: ' + traceback.format_exc())

g_webSock = _WebSock()
