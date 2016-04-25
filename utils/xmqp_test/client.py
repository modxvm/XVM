#!/usr/bin/env python

from AmqpClient import AmqpClient

with open('data/0.query.battle.channel.json','r') as f:
    get_exchange_name_query = f.read()

amqp_client = AmqpClient()

print(" [x] Requesting battle channel name")
battle_exchange = amqp_client.call(get_exchange_name_query)
print(" [.] Got %r" % battle_exchange)
amqp_client.bind_channel(battle_exchange)
