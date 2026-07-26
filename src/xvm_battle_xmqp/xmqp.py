"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2026 XVM Contributors
"""

__all__ = ['start', 'stop', 'call']

# stdlib
import json
import logging
import os
import Queue
import threading
import time
import uuid

# BigWorld
import BigWorld
from gui.battle_control import avatar_getter
from gui.shared import g_eventBus, events

# OpenWG
import openwg_mq
from xfw import *

# XVM
import xvm_main.config as config
import xvm_main.minimap_circles as minimap_circles
import xvm_main.utils as utils
from xvm_main.consts import *
from xvm_main.xvm import g_xvm
from xvm_battle.consts import *


XMQP_DEVELOPMENT = os.environ.get('XMQP_DEVELOPMENT') == '1'

_logger = logging.getLogger('XVM/Battle/XMQP')
if XMQP_DEVELOPMENT:
    _logger.setLevel(logging.DEBUG)

_PUBLISH_QUEUE_SIZE = 256
_POLL_TIMEOUT = 0.25
_LOBBY_TIMEOUT = 15.0
_RECONNECT_DELAY = 5.0
_RECONNECT_LIMIT = 3

_xmqp = None
_xmqp_thread = None
_start_generation = 0


def is_active():
    global _xmqp_thread, _xmqp
    return bool(_xmqp_thread and _xmqp and _xmqp.is_consuming)


def start():
    global _start_generation
    arena = avatar_getter.getArena()
    arena.onNewVehicleListReceived -= start
    _start_generation += 1
    generation = _start_generation
    BigWorld.callback(0, lambda: _start(generation))


def _on_services_initialized(*args):
    _start(_start_generation)


def _start(generation):
    if generation != _start_generation:
        return
    g_eventBus.removeListener(XVM_EVENT.XVM_SERVICES_INITIALIZED, _on_services_initialized)
    if not g_xvm.xvmServicesInitialized:
        g_eventBus.addListener(XVM_EVENT.XVM_SERVICES_INITIALIZED, _on_services_initialized)
        return

    if (config.networkServicesSettings.xmqp and not isReplay()) or XMQP_DEVELOPMENT:
        token = config.token.token
        if token:
            players = []

            arena = avatar_getter.getArena()
            if arena is not None:
                for vehicleID, vehicle_data in arena.vehicles.iteritems():
                    if vehicle_data['team'] == avatar_getter.getPlayerTeam():
                        players.append(vehicle_data['accountDBID'])

            if XMQP_DEVELOPMENT:
                account_db_id = utils.getAccountDBID()
                if account_db_id not in players:
                    players.append(account_db_id)

            players = sorted(set(players))

            stop(invalidate_start=False)
            if generation != _start_generation:
                return
            global _xmqp_thread, _xmqp
            _xmqp = _XMQP(players)
            _xmqp_thread = threading.Thread(target=_xmqp.start, name='xmqp')
            _xmqp_thread.setDaemon(True)
            _xmqp_thread.start()
            _logger.debug('Thread started')


def stop(invalidate_start=True):
    global _start_generation
    global _xmqp_thread, _xmqp
    if invalidate_start:
        _start_generation += 1
        g_eventBus.removeListener(XVM_EVENT.XVM_SERVICES_INITIALIZED, _on_services_initialized)
    thread = _xmqp_thread
    client = _xmqp
    if thread is not None:
        if client is not None:
            client.stop()
        thread.join()
        _logger.debug('Thread stopped')
    _xmqp_thread = None
    _xmqp = None


def call(message):
    global _xmqp
    if _xmqp:
        _xmqp.call(message)


def getCapabilitiesData():
    capabilities = {}
    minimap_data = minimap_circles.getMinimapCirclesData()
    if minimap_data:
        capabilities['sixthSense'] = minimap_data.get('commander_sixthSense', None)
    return capabilities


players_capabilities = {}


class _XMQP(object):
    """Owns one synchronous openwg_mq connection from one worker thread."""

    def __init__(self, players):
        self._players = players
        self._connection = None
        self._consumer_tag = None
        self._queue_name = None
        self._exchange_name = None
        self._exchange_correlation_id = None
        self._commands = Queue.Queue(_PUBLISH_QUEUE_SIZE)
        self._pending_publish = None
        self._closing = threading.Event()
        self._connected = threading.Event()
        self._reconnect_attempts = 0
        self._session_generation = 0

        global players_capabilities
        players_capabilities = {}

    @property
    def server_hash(self):
        return hash(tuple(self._players)) % 9 + 1

    @property
    def is_consuming(self):
        return self._connected.isSet()

    def start(self):
        _logger.debug('Starting')
        while not self._closing.isSet():
            self._session_generation += 1
            retry_session = False
            try:
                self._run_session()
            except openwg_mq.ConnectionError as ex:
                retry_session = True
                if not self._closing.isSet():
                    _logger.error('Connection failure (%s): %s', ex.operation, ex)
            except openwg_mq.AMQPError as ex:
                if not self._closing.isSet():
                    _logger.error('Permanent AMQP failure (%s): %s', ex.operation, ex)
            except Exception:
                if not self._closing.isSet():
                    _logger.exception('Worker failure')
            finally:
                self._connected.clear()
                self._exchange_name = None
                self._close_connection()

            if self._closing.isSet():
                break
            if not retry_session:
                break
            if self._reconnect_attempts >= _RECONNECT_LIMIT:
                _logger.debug('Connection closed, maximum reopen attempts reached')
                break

            self._reconnect_attempts += 1
            _logger.debug('Connection closed, reopening in %.0f seconds', _RECONNECT_DELAY)
            self._closing.wait(_RECONNECT_DELAY)

        _logger.debug('Stopped')

    def stop(self):
        _logger.debug('Stopping')
        self._closing.set()
        connection = self._connection
        if connection is not None:
            try:
                connection.close()
            except Exception:
                _logger.debug('Failed to close connection while stopping', exc_info=True)

    def call(self, data):
        if not self.is_consuming or self._exchange_name is None:
            return
        try:
            message = json.dumps(
                {'accountDBID': utils.getAccountDBID(), 'data': data},
                separators=(',', ':')
            )
            _logger.debug('call: %s', utils.hide_guid(message))
            self._commands.put_nowait(message)
        except Queue.Full:
            _logger.error('Publish queue is full; dropping message')
        except Exception:
            _logger.exception('Failed to enqueue message')

    def _run_session(self):
        host = XVM.XMQP_SERVER_TEMPLATE.format(HASH=self.server_hash)
        port = XVM.XMQP_SERVER_PORT_BASE + self.server_hash
        _logger.info('Connecting to %s:%s', host, port)

        connection = self._connect(host, port)
        if connection is None:
            return
        self._connection = connection
        if self._closing.isSet():
            connection.close()
            return
        _logger.debug('Connection and channel opened')

        self._queue_name = connection.declare_queue(exclusive=True)
        _logger.debug('queue: %s', self._queue_name)
        self._consumer_tag = connection.consume(self._queue_name, no_ack=True)
        self._request_exchange_name()
        lobby_deadline = time.time() + _LOBBY_TIMEOUT

        while not self._closing.isSet():
            if self._connected.isSet():
                self._publish_pending()
            message = connection.get_message(timeout=_POLL_TIMEOUT)
            if message is not None:
                self._on_message(message)
            if not self._connected.isSet() and time.time() >= lobby_deadline:
                raise openwg_mq.MQTimeoutError(
                    'lobby response timed out',
                    'lobby_handshake'
                )

    def _connect(self, host, port):
        last_error = None
        for attempt in xrange(3):
            if self._closing.isSet():
                return None
            connection = openwg_mq.Connection(
                host=host,
                port=port,
                virtual_host='xvm',
                username='xvm',
                password='xvm',
                connection_attempts=1,
                connect_timeout=1.0,
                handshake_timeout=12.0,
                rpc_timeout=5.0,
                heartbeat=15,
                teleport=True,
            )
            try:
                return connection.connect()
            except openwg_mq.ConnectionError as ex:
                last_error = ex
                connection.close()
                if attempt < 2 and self._closing.wait(3.0):
                    return None
        raise last_error

    def _request_exchange_name(self):
        _logger.debug('Getting exchange name')
        self._exchange_correlation_id = str(uuid.uuid4())
        message = json.dumps({
            'token': config.token.token,
            'players': self._players,
            'capabilities': json.dumps(getCapabilitiesData(), separators=(',', ':')),
        }, separators=(',', ':'))
        _logger.debug('%s', utils.hide_guid(message))
        self._connection.publish(
            exchange=XVM.XMQP_LOBBY_EXCHANGE,
            routing_key=XVM.XMQP_LOBBY_ROUTING_KEY,
            properties={
                'reply_to': self._queue_name,
                'correlation_id': self._exchange_correlation_id,
            },
            body=message,
        )

    def _publish_pending(self):
        published_count = 0
        while not self._closing.isSet() and published_count < 32:
            if self._pending_publish is None:
                try:
                    self._pending_publish = self._commands.get_nowait()
                except Queue.Empty:
                    return
            try:
                self._connection.publish(
                    exchange=self._exchange_name,
                    routing_key='',
                    body=self._pending_publish,
                )
            except Exception:
                raise
            else:
                self._pending_publish = None
                self._commands.task_done()
                published_count += 1

    def _on_message(self, message):
        if self._closing.isSet():
            return
        try:
            _logger.debug('recv: %s', message.body)
            correlation_id = message.properties.get('correlation_id')
            if self._exchange_correlation_id == correlation_id:
                response = json.loads(message.body)
                if 'exchange' not in response:
                    _logger.error("Invalid lobby response: response='%s'", message.body)
                    self.stop()
                    return

                self._exchange_name = response['exchange']
                global players_capabilities
                for account_db_id, data in response['users'].iteritems():
                    players_capabilities[int(account_db_id)] = json.loads(data) if data else {}

                _logger.debug('Binding %s to %s', self._exchange_name, self._queue_name)
                self._connection.bind_queue(self._queue_name, self._exchange_name)
                self._reconnect_attempts = 0
                self._connected.set()
                _logger.debug('Queue bound')
                self._dispatch_event(events.HasCtxEvent(XVM_BATTLE_EVENT.XMQP_CONNECTED))
            else:
                response = json.loads(message.body)
                self._dispatch_event(events.HasCtxEvent(XVM_BATTLE_EVENT.XMQP_MESSAGE, response))
        except openwg_mq.AMQPError:
            raise
        except Exception:
            _logger.exception('Failed to process message')

    def _dispatch_event(self, event):
        generation = self._session_generation
        def dispatch():
            if (not self._closing.isSet() and self._connected.isSet() and
                    generation == self._session_generation):
                g_eventBus.handleEvent(event)
        BigWorld.callback(0, dispatch)

    def _close_connection(self):
        connection = self._connection
        consumer_tag = self._consumer_tag
        self._connection = None
        self._consumer_tag = None
        self._queue_name = None
        if connection is None:
            return
        try:
            if not self._closing.isSet() and consumer_tag is not None and connection.is_open():
                connection.cancel(consumer_tag)
        except Exception:
            _logger.debug('Failed to cancel consumer', exc_info=True)
        try:
            connection.close()
        except Exception:
            _logger.debug('Failed to close connection', exc_info=True)
