#!/bin/sh

usage()
{
  echo "Usage: sh $0 <file> <xml-attribute-to-cut> [<xml-attribute-to-cut> ...]"
  echo "Example: sh cutxmlattr.sh DOMDocument.xml itemID sourceExternalFilepath sourceLastImported lastModified > DOMDocument.xml2"
  exit 1
}

[ -z $2 ] && usage

fn=$1
shift

[ ! -f "$fn" ] && {
  echo "ERROR: file '$fn' not found."
  usage
}

cmd="cat \"\$fn\""

for i in $*; do
  cmd="$cmd | sed \"s, *$i=\\\"[^\\\"]*\\\",,\""
done

eval "$cmd"