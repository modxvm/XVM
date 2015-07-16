#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2015
# XVM nightly build system

patch_swfs="
    Minimap.swf
"

for swf in $patch_swfs; do
    swf=${swf%.*}
    if [ ! -f ${swf}.xml ]; then
      echo ${swf}.swf
      java -jar ../../../build/bin/java/ffdec.jar -swf2xml orig/${swf}.swf orig/${swf}.xml
      java -jar ../../../build/bin/java/ffdec.jar -xml2swf orig/${swf}.xml orig/${swf}.swf.tmp
      java -jar ../../../build/bin/java/ffdec.jar -swf2xml orig/${swf}.swf.tmp orig/${swf}.xml
      java -jar ../../../build/bin/java/ffdec.jar -swf2xml ${swf}.swf ${swf}.xml
      diff -u2 orig/${swf}.xml ${swf}.xml > ${swf}.xml.patch
      # -I" numFillBits=\"1\"" -I" moveBits=\"1\"" -I" numLineBits=\"1\""
      rm orig/${swf}.xml ${swf}.xml orig/${swf}.swf.tmp
    fi
done
