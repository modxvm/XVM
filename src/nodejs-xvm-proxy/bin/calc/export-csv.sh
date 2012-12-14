#!/bin/bash

port=27017

mongo --port $port --quiet xvm export-csv.js > vstat.csv
