#!/bin/bash

port=27020
limit=50
limitHi=50
limitLo=1

url="http://127.0.0.1:1334/?"
fn=/tmp/xvm-db-tools.tmp

###

if [ "$1" = "expired" ]; then
    # expired
    echo "db.missed.find({missed:false}).forEach(function(x){print(x._id);})" | \
	mongo --port $port --quiet xvm | grep -v "bye" | \
	sort -n > $fn
#	sort -n -r > $fn
elif [ "$1" = "missed" ]; then
    # missed
    echo "db.missed.find({missed:true}).forEach(function(x){print(x._id);})" | \
	mongo --port $port --quiet xvm | grep -v "bye" | \
	sort -n > $fn
#	sort -n -r > $fn
elif [ "$1" = "query" ]; then
    # query
    shift
    echo "$*" | mongo --port $port --quiet xvm | grep -v "bye" | sort -n > $fn
    exit
else
    echo "Unknown command: $1"
    exit 1
fi

declare -A ids

last_limit_update=`date +%s`

update()
{
    local arr id st ids_str="" rmids="" fail=0 i cnt
    declare -A statuses

    cnt=0
    for i in ${ids[@]}; do
	[ "$ids_str" != "" ] && ids_str="$ids_str,"
	ids_str="$ids_str$i"
	cnt=$(($cnt + 1))
	[ $cnt -ge $limit ] && break
    done

    OIFS=$IFS
    IFS=$'\n'
    echo -n "."
    data=`wget -q -T 20 -O - "${url}${ids_str}" | tr -s '[]' '\n\n' | grep "id" | sed "s/},{/\n/g" | tr -d '"{}'`
    echo -n ". "
    [ "$data" = "" ] && { echo -n "[no data] "; sleep 1; }
    slp=0
    for line in $data; do
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
	    cache|ok|bad_id|closed|not_init)
		[ "$rmids" != "" ] && rmids="$rmids,"
		rmids="$rmids$id"
		unset ids[$id]
		;;
	    api_error)
		unset ids[$id]
		;;
	    fail|expired|error)
		echo -n " $st:$id"
		slp=1
		;;
	    wait|max_conn|fail)
		slp=1
		;;
	    *)
		echo "UNKNOWN STATUS: $st"
		exit
		;;
	esac
    done

    [ "$slp" = "1" ] && sleep 1

    IFS=$OIFS

    if [ "$rmids" != "" ]; then
	echo "db.missed.remove({_id: { \$in: [ $rmids ] }})" | mongo --port $port --quiet xvm >/dev/null
    fi

    echo "${statuses[*]}"
    if [ "${statuses[wait]}" != "" ]; then
	if [ $((`date +%s` - $last_limit_update)) -ge 2 ]; then
	    [ $limit -gt $limitLo ] && limit=$(($limit-1))
	    last_limit_update=`date +%s`
	fi
    elif [ "${statuses[max_conn]}" != "" ]; then
	if [ $((`date +%s` - $last_limit_update)) -ge 2 ]; then
	    [ $limit -gt $limitLo ] && limit=$(($limit-1))
	    last_limit_update=`date +%s`
	fi
    elif [ "${statuses[ok]}" != "" -o "${statuses[bad_id]}" != "" ]; then
	[ $limit -lt $limitHi ] && limit=$(($limit+1))
	last_limit_update=`date +%s`
    fi
}

# $1 - pos
# $2 - total
prepare()
{
    local first last i cnt
    while :; do
	[ ${#ids[@]} -lt $limit ] && break
	last=0
	first=0
	cnt=0
	for i in ${ids[@]}; do
	    [ $first -eq 0 -o $first -lt $i ] && first=$i
	    [ $last -eq 0 -o $last -gt $i ] && last=$i
	    cnt=$(($cnt + 1))
	    [ $cnt -ge $limit ] && break
	done
	if [ "$3" = "1" ]; then
	    echo -n "[$limit] $1/$2: $last..$first "
	else
	    echo -n "[$limit] $1/$2: $first..$last "
	fi
	update
    done
}

# main loop

total=$(wc -l $fn)
echo Total: $total
pos=0
ids=()
for id in $(cat $fn); do
    pos=$((pos+1))
    ids[$id]=$id
    prepare $pos $total 1
done
prepare $pos $total
rm -f $fn
