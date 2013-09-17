@echo off
md archives
cd archives

::Using 7-Zip (A) 9.20 for Windows command line

::Compessing type=deflate, method=w/o compression, multi-threading=on,
::store creation time=off, compress files open for writing=on, recursive
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-ru.zip  ..\clanicons\RU
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-eu.zip  ..\clanicons\EN
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-us.zip  ..\clanicons\US
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-sea.zip ..\clanicons\SEA
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-kr.zip  ..\clanicons\KR
cd ..