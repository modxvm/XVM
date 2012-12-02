#!/bin/bash

#QUERY="db.missed.find({missed:true}).forEach(function(x){print(x._id);})"
#QUERY="db.players.find({_id:{\$lt:10000000}, 'v.d':{\$exists:false}}).forEach(function(x){print(x._id);})"
#QUERY="db.players.find({_id:{\$lt:1000}, 'v.d':{\$exists:false}}).forEach(function(f){print(tojson(f, '', true));})"
#bash xvm-db-tools.sh query $QUERY
