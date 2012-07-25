#!/bin/bash

limit=2
limitHi=50
limitLo=1

url="http://proxy.bulychev.net/uc/?"
fn=missed.txt

###

if [ "$1" = "expired" ]; then
    # expired
    echo "db.missed.find({missed:false}).forEach(function(x){print(x._id);})" | mongo --quiet xvm | grep -v "bye" | sort -n -r > $fn
    #echo "db.missed.find({missed:false}).forEach(function(x){print(x._id);})" | mongo --quiet xvm | grep -v "bye" > $fn
else
    # missed
    echo "db.missed.find({missed:true}).forEach(function(x){print(x._id);})" | mongo --quiet xvm | grep -v "bye" | sort -n -r > $fn
fi

# $1 - url
# $2 - ids
update()
{
    local arr id st rmids="" fail=0
    declare -A statuses

    OIFS=$IFS
    IFS=$'\n'
    for line in `wget -q -O - "$1$2" | tr -s '[]' '\n\n' | grep "id" | sed "s/},{/\n/g" | tr -d '"{}'`; do
	IFS=$OIFS
	arr=(`echo "$line" | awk '{
	    n = split($0, a, ",")
	    id=0
	    status="-"
	    for (i = 0; ++i <= n;)
	    {
		split(a[i], b, ":")
		if (b[1] == "id")
		    id=b[2]
		if (b[1] == "status")
		    status=b[2]
	    }
	    print id, status
	}'`)
	id=${arr[0]}
	st=${arr[1]}
	statuses[$st]=$st
	case "$st" in
	    bad_id|cache|ok)
		[ "$rmids" != "" ] && rmids="$rmids,"
		rmids="$rmids$id"
		;;
	    wait|fail|error|max_conn|expired)
		limit=$limitLo
		sleep 0.1
		;;
	    *)
		echo "UNKNOWN STATUS: $st"
		exit
		;;
	esac
    done

    IFS=$OIFS

    if [ "$rmids" != "" ]; then
	echo "db.missed.remove({_id: { \$in: [ $rmids ] }})" | mongo --quiet xvm >/dev/null
	[ $limit -lt $limitHi ] && limit=$(($limit+1))
    fi

    echo ${statuses[*]}
}

# main loop

total=$(wc -l $fn)

pos=0
count=0
first=""
last=""
ids=""

for id in $(cat $fn); do
    pos=$((pos+1))

    [ "$ids" = "" ] && first="$id" || ids="$ids,"
    last="$id"

    count=$((count+1))
    ids="$ids$id"

    [ $count -lt $limit ] && continue

    echo -n "[$limit] $pos/$total: $first..$last "
    update "$url" "$ids"

    count=0
    ids=""
done

echo -n "[$limit] $pos/$total: $first..$last "
update "$url" "$ids"

rm -f $fn
