import pika
import uuid

credentials = pika.PlainCredentials('xvm', 'xvm')
lobby_queue = 'com.xvm.lobby'


class AmqpClient(object):
    def __init__(self):
        self.connection = pika.BlockingConnection(pika.ConnectionParameters(
            host='xmqp.modxvm.com', virtual_host='xvm', credentials=credentials))

        self.channel = self.connection.channel()

        result = self.channel.queue_declare(exclusive=True)
        self.private_queue = result.method.queue

        self.channel.basic_consume(self.on_response, no_ack=True,
                                   queue=self.private_queue)

    def on_response(self, ch, method, props, body):
        print('Message received: ', body, props)
        if self.corr_id == props.correlation_id:
            self.response = body

    def call(self, message):
        self.response = None
        self.corr_id = str(uuid.uuid4())
        self.channel.basic_publish(exchange='',
                                   routing_key=lobby_queue,
                                   properties=pika.BasicProperties(
                                       reply_to=self.private_queue,
                                       correlation_id=self.corr_id,
                                   ),
                                   body=str(message))
        while self.response is None:
            self.connection.process_data_events()
        return self.response

    def bind_channel(self, exchange_name):
        self.channel.queue_bind(exchange=exchange_name,
                                queue=self.private_queue)
        self.channel.start_consuming()
