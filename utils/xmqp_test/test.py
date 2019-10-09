#!/usr/bin/env python

import json
import sys
import time
from AmqpClient import AmqpClient

with open('data/1/0.query.battle.channel.json','r') as f:
    get_exchange_name_query = f.read()

if len(sys.argv[1:]):
    servers = [int(x) for x in sys.argv[1:]]
else:
    servers = range(1, 10)

def send(battle_exchange, fn):
    with open(fn,'r') as f:
        post_battle_msg_query = f.read()
    result = amqp_client.publish_battle_message(battle_exchange, post_battle_msg_query)
    print(" [.] Got %r" % result)

while 1:
    for i in servers:
        try:
            host = 'xmqp%d.modxvm.com' % i
            #port = 5672
            port = 5600 + i
            amqp_client = AmqpClient(host, port)
            response = json.loads(amqp_client.call(get_exchange_name_query, 'query.battle.channel'))
            battle_exchange = response['exchange']
            print("%s:%d [.] Exchange: %s" % (host, port, battle_exchange))
            #send(battle_exchange, 'data/1/1.data.json')
            amqp_client.connection.close()
        except Exception as ex:
            print("%s:%d ERROR: %s" % (host, port, str(ex)))

    time.sleep(0.3)
    print ('---')
    time.sleep(0.3)
