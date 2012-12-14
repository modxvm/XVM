#!/bin/bash

port=27017

mongo --port $port --quiet xvm export-xml.js > vstat.xml
