#!/bin/sh

sharddb_pid=/xvm/db/sharddb/mongod.lock

cat $sharddb_pid | xargs kill

sleep 5

su -m mongodb -c "/usr/bin/mongod -f /xvm/db/sharddb.conf --slowms 5000 &"
