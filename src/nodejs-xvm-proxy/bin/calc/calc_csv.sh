#!/bin/bash

port=27017
#mongo --port $port --quiet xvm calc_csv.js | tee calc.csv
mongo --port $port --quiet xvm calc_csv.js > calc.csv
