import pika
import uuid

credentials = pika.PlainCredentials('xvm', 'xvm')
lobby_queue = 'com.xvm.xmqp.2v0.lobby'


class AmqpClient(object):
    def __init__(self):
        self.connection = pika.BlockingConnection(pika.ConnectionParameters(
            host='xmqp1.modxvm.com', port=5601, virtual_host='xvm', credentials=credentials))

        self.channel = self.connection.channel()

        result = self.channel.queue_declare(exclusive=True)
        self.private_queue = result.method.queue

        self.channel.basic_consume(self.on_response, no_ack=True,
                                   queue=self.private_queue)

    def on_response(self, ch, method, props, body):
        print('Message received: ', body, props)
        if self.corr_id == props.correlation_id:
            self.response = body

    def call(self, message, routing_key):
        self.response = None
        self.corr_id = str(uuid.uuid4())
        self.channel.basic_publish(exchange=lobby_queue,
                                   routing_key=routing_key,
                                   properties=pika.BasicProperties(
                                       reply_to=self.private_queue,
                                       correlation_id=self.corr_id,
                                   ),
                                   body=str(message))
        while self.response is None:
            self.connection.process_data_events()
        return self.response

    def publish_battle_message(self, battle_exchange, message):
        self.channel.basic_publish(exchange=battle_exchange,
                                   routing_key='',
                                   body=str(message))

    def bind_channel(self, exchange_name):
        self.channel.queue_bind(exchange=exchange_name,
                                queue=self.private_queue)
        self.channel.start_consuming()
