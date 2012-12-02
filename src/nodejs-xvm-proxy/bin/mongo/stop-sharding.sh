#!/bin/sh

sharddb_pid=/xvm/db/sharddb/mongod.lock
configsvr_pid=/xvm/db/configdb/mongod.lock
mongos_pid=/xvm/db/mongos/mongos.pid

cat $sharddb_pid | xargs kill
cat $configsvr_pid | xargs kill
cat $mongos_pid | xargs kill
