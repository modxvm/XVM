#!/bin/bash

#XVM Vehicle Bank Parser builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

rm -rf ../../../src/vehicle-bank-parser/builds/*

pushd ../../../src/vehicle-bank-parser/ > /dev/null
xbuild VehicleBankParser.sln /p:Configuration="Release" /p:TargetFrameworkProfile="" /verbosity:quiet
popd > /dev/null
