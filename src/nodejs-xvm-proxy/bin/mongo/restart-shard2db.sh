#!/bin/sh

shard2db_pid=/xvm/db/shard2db/mongod.lock

cat $shard2db_pid | xargs kill

sleep 5

su -m mongodb -c "/usr/bin/mongod -f /xvm/db/shard2db.conf --slowms 5000 &"
