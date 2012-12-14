#!/bin/bash

port=27017

mongo --port $port --quiet xvm export.js > vstat.json
