#!/bin/sh

echo "Making packages of icons..."

mkdir archives
cd archives

#Using 7-Zip (A) 9.20 for Windows command line

#Compessing type=deflate, method=w/o compression, multi-threading=on,
#store creation time=off, compress files open for writing=on, recursive

echo "Making RU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-ru.zip  ..\clanicons\RU
echo "Making EU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-eu.zip  ..\clanicons\EN
echo "Making US package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-us.zip  ..\clanicons\US
echo "Making SEA package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-sea.zip ..\clanicons\SEA
echo "Making KR package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-kr.zip  ..\clanicons\KR

cd ..
echo "Packages are created"
