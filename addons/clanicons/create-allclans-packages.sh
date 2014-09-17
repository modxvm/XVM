#!/bin/sh
# Using 7-Zip (A) 9.20 for Windows command line

# Creating necessary files
fcreate()
{
    region=$1
    list=$2
    datenow=`date +%Y%m%d`

    # Zip package
    echo "Creating $region package"
    # Compessing type=deflate, method=w/o compression, multi-threading=on,
    # store creation time=off, compress files open for writing=on, recursive
    7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-$region-$datenow.zip $list readme.txt

    # MD5 sum
    echo -n "MD5 (clanicons-full-$region-$datenow.zip) = " > clanicons-full-$region-$datenow.zip.md5
    md5sum clanicons-full-$region-$datenow.zip | cut -c -33 | tr a-z A-Z >> clanicons-full-$region-$datenow.zip.md5

    # Readme
    echo "$region clan icons" > clanicons-full-$region-$datenow.zip.txt
    echo "" >> clanicons-full-$region-$datenow.zip.txt
    echo "Full archive with all $region clans." >> clanicons-full-$region-$datenow.zip.txt
    echo "" >> clanicons-full-$region-$datenow.zip.txt
    cat readme.txt >> clanicons-full-$region-$datenow.zip.txt
}


echo "Creating packages of icons..."

mkdir -p archives
cd archives

fcreate "KR"   "../icons/KR/res_mods/"
fcreate "ASIA" "../icons/ASIA/res_mods/"
fcreate "NA"   "../icons/NA/res_mods/"
fcreate "EU"   "../icons/EU/res_mods/"
fcreate "RU"   "../icons/RU/res_mods/"

cd ..
echo "Packages are created"

