#!/usr/bin/env python

import json
from AmqpClient import AmqpClient

with open('data/0.query.battle.channel.json','r') as f:
    get_exchange_name_query = f.read()

amqp_client = AmqpClient()

print(" [x] Requesting battle channel name")
response = json.loads(amqp_client.call(get_exchange_name_query, 'query.battle.channel'))
print(" [.] Got %r" % response)
battle_exchange = response['exchange']
amqp_client.bind_channel(battle_exchange)
