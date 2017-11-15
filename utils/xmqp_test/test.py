#!/usr/bin/env python

import json
import time
from AmqpClient import AmqpClient

with open('data/1/0.query.battle.channel.json','r') as f:
    get_exchange_name_query = f.read()

while 1:
    for i in range(1, 10):
        try:
            host = 'xmqp%d.modxvm.com' % i
            #port = 5672
            port = 5600 + i
            amqp_client = AmqpClient(host, port)
            response = json.loads(amqp_client.call(get_exchange_name_query, 'query.battle.channel'))
            print("%s:%d [.] Got %r" % (host, port, response))
            amqp_client.connection.close()
        except Exception as ex:
            print("%s:%d ERROR: %s" % (host, port, str(ex)))

    time.sleep(0.3)
    print ('---')
    time.sleep(0.3)
