#!/usr/bin/env python

import json
from AmqpClient import AmqpClient

with open('data/0.query.battle.channel.json','r') as f:
    get_exchange_name_query = f.read()

with open('data/1.data.json','r') as f:
    post_battle_msg_query = f.read()

amqp_client = AmqpClient()

print(" [x] Requesting battle channel name")
battle_exchange = amqp_client.call(get_exchange_name_query)
print(" [.] Got %r" % battle_exchange)
result = amqp_client.call(post_battle_msg_query)
print(" [.] Got %r" % result)
