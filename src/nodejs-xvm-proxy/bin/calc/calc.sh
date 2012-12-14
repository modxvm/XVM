#!/bin/bash

port=27017

start=`date`
echo $start
mongo --port $port --quiet xvm calc.js
end=`date`
echo start: $start
echo end: $end
