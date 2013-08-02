#!/bin/bash

#XVM builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

#1. Detect revision
pushd ../../ > /dev/null
revision=$(svnversion | head -c 4)
popd > /dev/null

#2. Detect WoT version
pushd config/ > /dev/null
wot_version_release=$(cat wot_version_release)
wot_version_ct=$(cat wot_version_ct)
popd > /dev/null

#3. Build XVM
pushd sh > /dev/null
./xvm-build.sh
popd > /dev/null

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
pushd ../../temp/rel/ > /dev/null && zip -9 -r -q "$revision"_release.zip ./ && popd > /dev/null
pushd ../../temp/ct/ > /dev/null && zip -9 -r -q "$revision"_ct.zip ./ && popd > /dev/null

#7. Move&Clean
rm -rf ../../bin/*
mv -f ../../temp/rel/"$revision"_release.zip ../../bin/
mv -f ../../temp/ct/"$revision"_ct.zip ../../bin/
rm -rf ../../temp/

