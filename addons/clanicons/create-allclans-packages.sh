#!/bin/sh
#Using 7-Zip (A) 9.20 for Windows command line
#Compessing type=deflate, method=w/o compression, multi-threading=on,
#store creation time=off, compress files open for writing=on, recursive

echo "Creating packages of icons..."

mkdir -p archives
cd archives

datenow=`date +%Y%m%d`

echo "Creating VN package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-kr-$datenow.zip  ../icons/VTC/res_mods/ readme.txt
echo "Creating KR package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-kr-$datenow.zip  ../icons/KR/res_mods/ readme.txt
echo "Creating SEA package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-sea-$datenow.zip ../icons/SEA/res_mods/ readme.txt
echo "Creating NA package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-us-$datenow.zip  ../icons/US/res_mods/ readme.txt
echo "Creating EU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-eu-$datenow.zip  ../icons/EU/res_mods/ readme.txt
echo "Creating RU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-ru-$datenow.zip  ../icons/RU/res_mods/ readme.txt

cd ..
echo "Packages are created"
