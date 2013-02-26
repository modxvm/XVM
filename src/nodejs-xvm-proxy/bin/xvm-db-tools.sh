#!/bin/bash

port=27017
limit=50
limitHi=50
limitLo=1

url="http://127.0.0.1:1334/?"
#url="http://proxy.bulychev.net:1303/?"
fn=/tmp/xvm-db-tools.tmp

###

cmd=$1

if [ "$1" = "expired" ]; then
limitRows=1000000
#limit=100
limitHi=100
    # expired
    echo "db.missed.find({missed:false}).limit($limitRows).forEach(function(x){print(x._id);})" | \
	mongo --port $port --quiet xvm2 | grep -v "bye" | \
	sort -n > $fn
#	sort -n -r > $fn
elif [ "$1" = "checkcache" ]; then
limitRows=3000000
limit=100
limitHi=100
    # expired
    echo "db.missed.find({}).limit($limitRows).forEach(function(x){print(x._id);})" | \
	mongo --port $port --quiet xvm2 | grep -v "bye" | \
	sort -n > $fn
#	sort -n -r > $fn
elif [ "$1" = "missed" ]; then
limitRows=3000000
    # missed
    echo "db.missed.find({missed:true}).limit($limitRows).forEach(function(x){print(x._id);})" | \
	mongo --port $port --quiet xvm2 | grep -v "bye" | \
	sort -n > $fn
#	sort -n -r > $fn
elif [ "$1" = "query" ]; then
    # query
    shift
    echo "$*" | mongo --port $port --quiet xvm2 | grep -v "bye" | sort -n > $fn
    exit
else
    echo "Unknown command: $1"
    exit 1
fi

declare -A ids

last_limit_update=`date +%s`

update()
{
    local arr id st ids_str="" rmids="" fail=0 i cnt st_ok st_err
    declare -A statuses

    st_ok=0
    st_err=0

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
	statuses[$st]=$((${statuses[$st]} + 1))
	case "$st" in
	    cache|ok|bad_id|closed|not_init)
		st_ok=1
		[ "$rmids" != "" ] && rmids="$rmids,"
		rmids="$rmids$id"
		unset ids[$id]
		;;
	    api_error)
		unset ids[$id]
		;;
	    wait|max_conn|error|timeout|502|503|400|403|404|406|parse)
		st_err=1
#		[ "$cmd" = "checkcache" ] && unset ids[$id] || slp=1
		;;
	    fail)
		st_err=1
		echo -n "$st:$id "
		[ "$cmd" = "checkcache" ] && unset ids[$id] || slp=1
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
	echo "db.missed.remove({_id: { \$in: [ $rmids ] }})" | mongo --port $port --quiet xvm2 >/dev/null
    fi

    for i in ${!statuses[@]}; do
	echo -n "$i(${statuses[$i]}) "
    done
    echo
    if [ "$cmd" != "checkcache" ]; then
        if [ "$st_err" = "1" ]; then
	    if [ $((`date +%s` - $last_limit_update)) -ge 2 ]; then
		[ $limit -gt $limitLo ] && limit=$(($limit-1))
		last_limit_update=`date +%s`
	    fi
	elif [ "$st_ok" = "1" ]; then
	    [ $limit -lt $limitHi ] && limit=$(($limit+1))
	    last_limit_update=`date +%s`
	fi
    fi
}

# $1 - pos
# $2 - total
# $3 - 2 for last update
prepare()
{
    local first last i cnt
    while :; do
	[ ${#ids[@]} -lt $limit ] && break
#	[ ${#ids[@]} -lt $limit -a "$3" != "2" ] && break
	last=0
	first=0
	cnt=0
	for i in ${ids[@]}; do
	    [ $first -eq 0 -o $first -lt $i ] && first=$i
	    [ $last -eq 0 -o $last -gt $i ] && last=$i
	    cnt=$(($cnt + 1))
	    [ $cnt -ge $limit ] && break
	done
	echo -n "[$limit] $1/$2: $last..$first "
	update
    done
}

# main loop

total=$(wc -l $fn | xargs echo | cut -d' ' -f1)
echo Total: $total
pos=0
ids=()
cat $fn | while read id; do
    pos=$((pos+1))
    ids[$id]=$id
    prepare $pos $total "1"
done
prepare $pos $total "2"

rm -f $fn
