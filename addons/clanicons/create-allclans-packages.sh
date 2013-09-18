#!/bin/sh

echo "Creating packages of icons..."

mkdir -p archives
cd archives

#Using 7-Zip (A) 9.20 for Windows command line

#Compessing type=deflate, method=w/o compression, multi-threading=on,
#store creation time=off, compress files open for writing=on, recursive

echo "Creating RU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-ru.zip  ../icons/RU/res_mods/ readme.txt
echo "Creating EU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-eu.zip  ../icons/EN/res_mods/ readme.txt
echo "Creating US package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-us.zip  ../icons/US/res_mods/ readme.txt
echo "Creating SEA package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-sea.zip ../icons/SEA/res_mods/ readme.txt
echo "Creating KR package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-kr.zip  ../icons/KR/res_mods/ readme.txt

cd ..
echo "Packages are created"
