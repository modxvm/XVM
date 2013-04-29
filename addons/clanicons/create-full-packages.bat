@echo off
cd all
7z a -tzip -mm=Deflate -mx=0 -mtc=off -r clanicons-full-eu.zip clanicons\EU
7z a -tzip -mm=Deflate -mx=0 -mtc=off -r clanicons-full-ru.zip clanicons\RU
7z a -tzip -mm=Deflate -mx=0 -mtc=off -r clanicons-full-us.zip clanicons\US
cd ..
