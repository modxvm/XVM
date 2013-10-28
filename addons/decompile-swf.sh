#!/bin/sh

ffdec="C:\\Program Files (x86)\\FFDec\\ffdec.jar"

cfg=autoDeobfuscate=1,parallelSpeedUp=0
exp=as
#exp=all

for i in *.swf; do
  echo $i
  java -Xmx1024m -jar "$ffdec" -config $cfg -export $exp ${i/.swf/} $i >/dev/null 2>&1
done
