#!/usr/bin/env python

import json
from AmqpClient import AmqpClient

with open('data/1/0.query.battle.channel.json','r') as f:
    get_exchange_name_query = f.read()

amqp_client = AmqpClient()

print(" [x] Requesting battle channel name")
response = json.loads(amqp_client.call(get_exchange_name_query, 'query.battle.channel'))
print(" [.] Got %r" % response)
battle_exchange = response['exchange']

def send(fn):
    with open(fn,'r') as f:
        post_battle_msg_query = f.read()
    result = amqp_client.publish_battle_message(battle_exchange, post_battle_msg_query)
    print(" [.] Got %r" % result)

send('data/1/1.data.json')
send('data/1/2.data.json')
send('data/1/3.data.json')
