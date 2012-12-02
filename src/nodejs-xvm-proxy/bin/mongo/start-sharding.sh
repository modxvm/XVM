#!/bin/sh

sharddb_pid=/xvm/db/sharddb/mongod.lock
configsvr_pid=/xvm/db/configdb/mongod.lock
mongos_pid=/xvm/db/mongos/mongos.pid

. ./stop-sharding.sh

sleep 5

su -m mongodb -c "/usr/bin/mongod -f /xvm/db/sharddb.conf --slowms 5000 &"
su -m mongodb -c "/usr/bin/mongod --configsvr --dbpath /xvm/db/configdb --port 27019 --logpath /var/log/mongodb/configsvr.log &"
sleep 5
su -m mongodb -c "/usr/bin/mongos --configdb bulychev.net:27019 --port 27020 --logpath /var/log/mongodb/mongos.log --pidfilepath $mongos_pid &"
