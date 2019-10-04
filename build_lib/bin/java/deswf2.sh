#!/bin/bash

ffdec="$(dirname $(realpath $(cygpath --unix $0)))/ffdec.sh"
cfg=autoDeobfuscate=0,parallelSpeedUp=0
fmt=fla:cs6
exp=fla
#exp=all

for i in *.swf; do
  if [ "$i" != "*.swf" ]; then
    echo "$i"
    "$ffdec" -config $cfg -format $fmt -export $exp "${i/.swf/}/${i/.swf/}.fla" "$i" >"$i.log" 2>"$i.err"
  fi
done
