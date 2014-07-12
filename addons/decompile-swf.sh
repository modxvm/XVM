#!/bin/sh

ffdec="C:\\Program Files (x86)\\FFDec\\ffdec.jar"

cfg=autoDeobfuscate=1,parallelSpeedUp=0
exp=script
fmt=script:as
#exp=all


for i in *.swf; do
  echo $i
  java -Xmx1024m -jar "$ffdec" -config $cfg -format $fmt -export $exp ${i/.swf/} $i >$i.log 2>$i.err
  #java -Xmx1024m -jar "$ffdec" -config $cfg -format $fmt -export $exp ${i/.swf/} $i -selectas3class net.wg.gui.login.impl.ErrorStates
done
