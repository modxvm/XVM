#!/bin/bash

#XVM nightly builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

#1. Detect revision
pushd ../../
revision=$(svn up | tail -1 | sed 's/[A-Za-zА-Яа-я.]*//g' | sed 's/^[ \t]*//g') #locale-independent magic
popd

#2. Detect WoT version
pushd config/
wot_version_release=$(cat wot_version_release)
wot_version_ct=$(cat wot_version_ct)
popd

#3. Build XVM
pushd sh
./xvm-build.sh
popd

#4. Make dirs
mkdir -p ../../temp/rel/"$wot_version_release"/gui/flash
mkdir -p ../../temp/ct/"$wot_version_ct"/gui/flash

#5. Copy swfs,config,l10n,docs etc.
cp -rf ../../bin/* ../../temp/rel/"$wot_version_release"/gui/flash/
cp -rf ../../bin/* ../../temp/ct/"$wot_version_ct"/gui/flash/

cp -rf ../../release/ ../../temp/rel/xvm/
cp -rf ../../release/ ../../temp/ct/xvm/

mv -f ../../temp/rel/xvm/xvm.xc.sample ../../temp/rel/xvm/xvm.xc
mv -f ../../temp/ct/xvm/xvm.xc.sample ../../temp/ct/xvm/xvm.xc

#6. Build zips
pushd ../../temp/rel/ && zip -9 -r "$revision"_release.zip ./ && popd
pushd ../../temp/ct/ && zip -9 -r "$revision"_ct.zip ./ && popd

#7. Move&Clean
rm -rf ../../bin/*
mv -f ../../temp/rel/"$revision"_release.zip ../../bin/
mv -f ../../temp/ct/"$revision"_ct.zip ../../bin/
rm -rf ../../temp/

