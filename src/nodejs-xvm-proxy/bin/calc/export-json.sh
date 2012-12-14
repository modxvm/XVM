#!/bin/bash

port=27017

echo "db.vstat.find({}, {_id:0}).forEach(function(x){printjson(x)})" |mongo --port $port --quiet xvm > vstat2.json
