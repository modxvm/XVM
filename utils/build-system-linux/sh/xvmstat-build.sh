#!/bin/bash

#XVM-Stat builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

rm -rf ../../../src/xvm-stat/bin/*
rm -rf ../../../src/xvm-stat/obj/*

pushd ../../../src/xvm-stat/ > /dev/null
xbuild xvm-stat.csproj /p:Configuration="Release" /p:TargetFrameworkVersion="$1" /p:TargetFrameworkProfile="" /p:SignAssembly="False" /p:win32icon="WoT.ico" /verbosity:quiet
cp SQLite/Community.CsharpSqlite.dll bin/Release/ #FIXME: google about xbuild and static linking
popd > /dev/null
