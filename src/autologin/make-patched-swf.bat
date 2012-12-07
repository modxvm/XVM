@echo off
cd swf
swfmill swf2xml login.swf.orig login.xml.orig
copy /Y login.xml.orig login.xml > nul
patch < login.xml.patch
swfmill xml2swf login.xml login.swf
del login.xml login.xml.orig
cd ..
