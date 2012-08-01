@echo off
cd all
7z a -tzip -mm=Deflate -mx=0 -mtc=off -r clanicons-full-eu.zip res_mods\clanicons\EU
7z a -tzip -mm=Deflate -mx=0 -mtc=off -r clanicons-full-ru.zip res_mods\clanicons\RU
7z a -tzip -mm=Deflate -mx=0 -mtc=off -r clanicons-full-us.zip res_mods\clanicons\US
cd ..
