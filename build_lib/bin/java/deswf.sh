#!/bin/bash

ffdec="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/ffdec.sh"
cfg=autoDeobfuscate=0,parallelSpeedUp=0
fmt=script:as
exp=script
#exp=all

for i in *.swf; do
  if [ "$i" != "*.swf" ]; then
    echo "$i"
    "$ffdec" -config $cfg -format $fmt -export $exp "${i/.swf/}" "$i" >"$i.log" 2>"$i.err"
  fi
done
