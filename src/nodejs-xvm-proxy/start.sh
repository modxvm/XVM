#!/bin/sh

log=/xvm/log/proxy.log
proxy=/xvm/proxy_shard/proxy.js
proxy2=/xvm/proxy/proxy.js

#node $proxy; exit # foreground

forever stop $proxy > /dev/null 2>&1
forever stop $proxy2 > /dev/null 2>&1
rm -f $log
forever start -l $log $proxy
echo
forever list
echo
echo "tail -F $log"
echo
