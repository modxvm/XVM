#!/bin/bash

rm -rf ../../release/l10n/*
mkdir -p ../../release/l10n/
cp ../../temp/* ../../release/l10n/
files=$(find ../../release/l10n/ -type f -name *.po)

for file in $files
do
        po2csv --progress=none --columnorder=location,target $file $file.xc

        #del first line
        sed -i '1d' $file.xc

        #change field delimiter        
        sed -i 's|","|": "|g' $file.xc

        #add trailing ,
        sed -i 's/.$/,/' $file.xc
        sed -i '$s/,$//' $file.xc

        #add file header
        ed -s $file.xc << 'EOF'
0a
{
  "locale": {
.
$a
  }
}
.
w
EOF

        rename 's/\.po.xc$/\.xc/' $file.xc
        rm $file
done
