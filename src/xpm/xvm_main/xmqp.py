""" XVM (c) www.modxvm.com 2013-2016 """

__all__ = ['start', 'stop', 'call']

# PUBLIC

import os
import threading

from pika import exceptions as pika_exceptions

XMQP_DEVELOPMENT = os.environ.get('XMQP_DEVELOPMENT') == '1'

_xmqp = None
_xmqp_thread = None

def is_active():
    global _xmqp_thread, _xmqp
    return _xmqp_thread and _xmqp.is_consuming

def start(players):
    global _xmqp_thread, _xmqp
    if _xmqp:
        stop()
    _xmqp = _XMQP(players)
    _xmqp_thread = threading.Thread(target=_xmqp.start, name='xmqp')
    _xmqp_thread.setDaemon(True)
    _xmqp_thread.start()
    debug('[XMQP] Thread started')

def stop():
    global _xmqp_thread, _xmqp
    if _xmqp_thread:
        _xmqp.stop()
        _xmqp_thread.join()
        _xmqp_thread = None
        debug('[XMQP] Thread stopped')
    _xmqp = None

def call(message):
    global _xmqp
    if _xmqp:
        _xmqp.call(message)


# PRIVATE

import pika
import simplejson
import traceback
import uuid

from gui.shared import g_eventBus, events

from xfw import *

import config
from constants import *
from logger import *

class _XMQP(object):
    """This is an xmqp consumer that will handle unexpected interactions
    with RabbitMQ such as channel and connection closures.

    If RabbitMQ closes the connection, it will reopen it. You should
    look at the output, as there are limited reasons why the connection may
    be closed, which usually are tied to permission related issues or
    socket timeouts.

    If the channel is closed, it will indicate a problem with one of the
    commands that were issued and that should surface in the output as well.

    """
    LOBBY_QUEUE = 'com.xvm.lobby'

    def __init__(self, players):
        """Create a new instance of the consumer class, passing in the AMQP
        URL used to connect to RabbitMQ.

        """
        self._players = players
        self._consuming = False
        self._closing = False
        self._connection = None
        self._channel = None
        self._consumer_tag = None
        self._exchange_name = None
        self._queue_name = None
        self._correlation_id = None
        self._exchange_correlation_id = None
        self._reconnect_attempts = 0

    @property
    def is_consuming(self):
        return self._consuming

    def start(self):
        """Run the xmqp consumer by connecting to RabbitMQ and then
        starting the IOLoop to block and allow the SelectConnection to operate.
        """
        debug('[XMQP] Starting')
        self._connection = self.connect()
        self.start_ioloop()

    def stop(self):
        """Cleanly shutdown the connection to RabbitMQ by stopping the consumer
        with RabbitMQ. When RabbitMQ confirms the cancellation, on_cancelok
        will be invoked by pika, which will then closing the channel and
        connection. The IOLoop is started again because this method is invoked
        when CTRL-C is pressed raising a KeyboardInterrupt exception. This
        exception stops the IOLoop which needs to be running for pika to
        communicate with RabbitMQ. All of the commands issued prior to starting
        the IOLoop will be buffered but not processed.

        """
        try:
            debug('[XMQP] Stopping')
            self._connection.ioloop.stop()
            if self.is_consuming:
                self.stop_consuming()
                self._connection.ioloop.start()
            if self._channel and self._channel.is_open:
                self.close_channel()
                #self._connection.ioloop.start()
            if self._connection and self._connection.is_open:
                self.close_connection()
                #self._connection.ioloop.start()
            self._connection.ioloop.stop()
            debug('[XMQP] Stopped')
        except (pika_exceptions.ChannelClosed, pika_exceptions.ConnectionClosed):
            debug(traceback.format_exc())
        except Exception as ex:
            err(traceback.format_exc())

    def call(self, data):
        if self.is_consuming:
            self._correlation_id = str(uuid.uuid4())
            message = simplejson.dumps({
                'message': simplejson.dumps(data),
                'type': XVM.XMQP_COMMAND_BATTLE_MESSAGE,
                'token': config.token.token})
            #debug('[XMQP] call: %s' % message)
            self._channel.basic_publish(
                exchange='',
                routing_key=self.LOBBY_QUEUE,
                properties=pika.BasicProperties(
                    reply_to=self._queue_name,
                    correlation_id=self._correlation_id),
                body=message)

    # INTERNAL

    def on_message(self, unused_channel, basic_deliver, properties, body):
        """Invoked by pika when a message is delivered from RabbitMQ. The
        channel is passed for your convenience. The basic_deliver object that
        is passed in carries the exchange, delivery tag and a redelivered flag
        for the message. The properties passed in is an instance of
        BasicProperties with the message properties and the body is the
        message that was sent.

        :param pika.channel.Channel unused_channel: The channel object
        :param pika.Spec.Basic.Deliver: basic_deliver method
        :param pika.Spec.BasicProperties: properties
        :param str|unicode body: The message body

        """
        if self._closing:
            return
        try:
            if body != 'ok':
                debug('[XMQP] Received message #%s: %s headers=%s' % \
                    (basic_deliver.delivery_tag, body, str(properties.headers)))
            if self._exchange_correlation_id == properties.correlation_id:
                self._exchange_name = body
            elif basic_deliver.exchange:
                #debug('[XMQP] recv: {} {}'.format(properties.headers.get('userId', None), body))
                g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.XMQP_MESSAGE, {
                    'playerId': properties.headers.get('userId', None),
                    'body':simplejson.loads(body)}))
            if self._exchange_correlation_id == properties.correlation_id:
                self.bind_channel()
        except Exception as ex:
            err(traceback.format_exc())

    def start_ioloop(self):
        try:
            self._connection.ioloop.start()
        except Exception as ex:
            err(traceback.format_exc())

    def connect(self):
        """This method connects to RabbitMQ, returning the connection handle.
        When the connection is established, the on_connection_open method
        will be invoked by pika.

        :rtype: pika.SelectConnection

        """
        debug('[XMQP] Connecting')

        credentials = pika.PlainCredentials('xvm', 'xvm')
        params = pika.ConnectionParameters(
            host=XVM.XMQP_SERVER,
            #port=XVM.XMQP_SERVER_PORT,
            virtual_host='xvm',
            credentials=credentials,
            #channel_max=None,
            #frame_max=None,
            #heartbeat=None,
            #ssl=None,
            #ssl_options=None,
            connection_attempts=3,
            retry_delay=3,
            socket_timeout=1,
            #locale=None,
            #backpressure_detection=None,
            blocked_connection_timeout=5)
            #client_properties=_DEFAULT)

        return pika.SelectConnection(
            params,
            on_open_error_callback=self.on_open_connection_error,
            on_open_callback=self.on_connection_open,
            stop_ioloop_on_close=False)

    def on_open_connection_error(self, unused_connection, error_message=None):
        err('[XMQP] on_open_connection_error %s' % repr(pika_exceptions.AMQPConnectionError(error_message or
            self._connection.params.connection_attempts)))
        self._connection.ioloop.stop()

    def on_connection_open(self, unused_connection):
        """This method is called by pika once the connection to RabbitMQ has
        been established. It passes the handle to the connection object in
        case we need it, but in this case, we'll just mark it unused.

        :type unused_connection: pika.SelectConnection

        """
        debug('[XMQP] Connection opened')
        self.add_on_connection_close_callback()
        self.open_channel()

    def on_connection_closed(self, connection, reply_code, reply_text):
        """This method is invoked by pika when the connection to RabbitMQ is
        closed unexpectedly. Since it is unexpected, we will reconnect to
        RabbitMQ if it disconnects.

        :param pika.connection.Connection connection: The closed connection obj
        :param int reply_code: The server provided reply_code if given
        :param str reply_text: The server provided reply_text if given

        """
        self._consuming = False
        self._channel = None
        if self._closing:
            self._connection.ioloop.stop()
        elif self._reconnect_attempts >= 3:
            debug('[XMQP] Connection closed, maximum reopen attempts reached')
            self._connection.ioloop.stop()
        else:
            debug('[XMQP] Connection closed, reopening in 5 seconds: (%s) %s' % (reply_code, reply_text))
            self._connection.add_timeout(5, self.reconnect)

    def reconnect(self):
        """Will be invoked by the IOLoop timer if the connection is
        closed. See the on_connection_closed method.

        """
        debug('[XMQP] Reconnecting')

        # This is the old connection IOLoop instance, stop its ioloop
        self._connection.ioloop.stop()

        if not self._closing:
            self._reconnect_attempts += 1
            self._connection = self.connect()
            self.start_ioloop()

    def open_channel(self):
        """Open a new channel with RabbitMQ by issuing the Channel.Open RPC
        command. When RabbitMQ responds that the channel is open, the
        on_channel_open callback will be invoked by pika.

        """
        debug('[XMQP] Creating a new channel')
        self._connection.channel(on_open_callback=self.on_channel_open)

    def on_channel_open(self, channel):
        """This method is invoked by pika when the channel has been opened.
        The channel object is passed in so we can make use of it.

        Since the channel is now open, we'll declare the exchange to use.

        :param pika.channel.Channel channel: The channel object

        """
        if self._closing:
            return
        debug('[XMQP] Channel opened')
        self._channel = channel
        self.add_on_channel_close_callback()
        self.setup_queue()

    def setup_queue(self):
        """Setup the queue on RabbitMQ by invoking the Queue.Declare RPC
        command. When it is complete, the on_queue_declareok method will
        be invoked by pika.

        """
        debug('[XMQP] Declaring queue')
        self._channel.queue_declare(self.on_queue_declareok, exclusive=True)

    def on_queue_declareok(self, method_frame):
        """Method invoked by pika when the Queue.Declare RPC call made in
        setup_queue has completed. In this method we will bind the queue
        and exchange by issuing the Queue.Bind RPC command.
        When this command is complete, the on_bindok method will
        be invoked by pika.

        :param pika.frame.Method method_frame: The Queue.DeclareOk frame

        """
        if self._closing:
            return
        self._queue_name = method_frame.method.queue
        debug('[XMQP] queue: %s' % (self._queue_name))
        self.start_consuming()
        self.get_exchange_name()

    def start_consuming(self):
        """This method sets up the consumer by first calling
        add_on_cancel_callback so that the object is notified if RabbitMQ
        cancels the consumer. It then issues the Basic.Consume RPC command
        which returns the consumer tag that is used to uniquely identify the
        consumer with RabbitMQ. We keep the value to use it when we want to
        cancel consuming. The on_message method is passed in as a callback pika
        will invoke when a message is fully received.

        """
        debug('[XMQP] Issuing consumer related RPC commands')
        self._consuming = True
        self.add_on_cancel_callback()
        self._consumer_tag = self._channel.basic_consume(self.on_message, self._queue_name, no_ack=True)

    def get_exchange_name(self):
        debug('[XMQP] Getting exchange name')
        self._exchange_correlation_id = str(uuid.uuid4())
        message = simplejson.dumps({
            'type': XVM.XMQP_EXCHANGE_NAME_QUERY,
            'token': config.token.token,
            'players': self._players})
        debug(message)
        self._channel.basic_publish(
            exchange='',
            routing_key=self.LOBBY_QUEUE,
            properties=pika.BasicProperties(
                reply_to=self._queue_name,
                correlation_id=self._exchange_correlation_id,
            ),
            body=message)

    def bind_channel(self):
        debug('[XMQP] Binding %s to %s' % (self._exchange_name, self._queue_name))
        self._channel.queue_bind(self.on_bindok, self._queue_name, self._exchange_name)

    def on_bindok(self, unused_frame):
        """Invoked by pika when the Queue.Bind method has completed. At this
        point we will start consuming messages by calling start_consuming
        which will invoke the needed RPC commands to start the process.

        :param pika.frame.Method unused_frame: The Queue.BindOk response frame

        """
        debug('[XMQP] Queue bound')
        self._reconnect_attempts = 0
        g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.XMQP_CONNECTED))


    # service methods

    def add_on_connection_close_callback(self):
        """This method adds an on close callback that will be invoked by pika
        when RabbitMQ closes the connection to the publisher unexpectedly.

        """
        debug('[XMQP] Adding connection close callback')
        self._connection.add_on_close_callback(self.on_connection_closed)

    def add_on_channel_close_callback(self):
        """This method tells pika to call the on_channel_closed method if
        RabbitMQ unexpectedly closes the channel.

        """
        debug('[XMQP] Adding channel close callback')
        self._channel.add_on_close_callback(self.on_channel_closed)

    def on_channel_closed(self, channel, reply_code, reply_text):
        """Invoked by pika when RabbitMQ unexpectedly closes the channel.
        Channels are usually closed if you attempt to do something that
        violates the protocol, such as re-declare an exchange or queue with
        different parameters. In this case, we'll close the connection
        to shutdown the object.

        :param pika.channel.Channel: The closed channel
        :param int reply_code: The numeric reason the channel was closed
        :param str reply_text: The text reason the channel was closed

        """
        debug('[XMQP] Channel %i was closed: (%s) %s' % (channel, reply_code, reply_text))
        self._connection.close()

    def add_on_cancel_callback(self):
        """Add a callback that will be invoked if RabbitMQ cancels the consumer
        for some reason. If RabbitMQ does cancel the consumer,
        on_consumer_cancelled will be invoked by pika.

        """
        debug('[XMQP] Adding consumer cancellation callback')
        self._channel.add_on_cancel_callback(self.on_consumer_cancelled)

    def on_consumer_cancelled(self, method_frame):
        """Invoked by pika when RabbitMQ sends a Basic.Cancel for a consumer
        receiving messages.

        :param pika.frame.Method method_frame: The Basic.Cancel frame

        """
        debug('[XMQP] Consumer was cancelled remotely, shutting down: %r' % (method_frame))
        if self._channel:
            self._channel.close()

    def stop_consuming(self):
        """Tell RabbitMQ that you would like to stop consuming by sending the
        Basic.Cancel RPC command.

        """
        self._consuming = False
        self._closing = True
        if self._channel:
            debug('[XMQP] Sending a Basic.Cancel RPC command to RabbitMQ')
            self._channel.basic_cancel(self.on_cancelok, self._consumer_tag)

    def on_cancelok(self, unused_frame):
        """This method is invoked by pika when RabbitMQ acknowledges the
        cancellation of a consumer. At this point we will close the channel.
        This will invoke the on_channel_closed method once the channel has been
        closed, which will in-turn close the connection.

        :param pika.frame.Method unused_frame: The Basic.CancelOk frame

        """
        debug('[XMQP] RabbitMQ acknowledged the cancellation of the consumer')
        self.close_channel()

    def close_channel(self):
        """Call to close the channel with RabbitMQ cleanly by issuing the
        Channel.Close RPC command.

        """
        debug('[XMQP] Closing the channel')
        self._consuming = False
        self._closing = True
        if self._channel is not None:
            self._channel.close()

    def close_connection(self):
        """This method closes the connection to RabbitMQ."""
        debug('[XMQP] Closing connection')
        self._consuming = False
        self._closing = True
        self._connection.close()
