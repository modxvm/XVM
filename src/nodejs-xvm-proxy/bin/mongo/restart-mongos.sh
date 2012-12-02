#!/bin/sh

mongos_pid=/xvm/db/mongos/mongos.pid

cat $mongos_pid | xargs kill
sleep 5
su -m mongodb -c "/usr/bin/mongos --configdb bulychev.net:27019 --port 27020 --logpath /var/log/mongodb/mongos.log --pidfilepath $mongos_pid &"
