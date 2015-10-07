#!/bin/sh


#weave port
wp='6783'
re='(?<=\[)(.*?)(?=:'${wp}'])'
#connection timeout
to=5
#bad and not scalable
#nccmd="docker run --rm busybox nc"
#does not have the port scanner!
nccmd="/usr/bin/ncat" 

while true
do
    # assuming index 0 is self
    mypeers=`/opt/bin/weave report | \
             /usr/bin/jq '.Router.Peers[0].Connections'`
    npeers=`echo $mypeers | /usr/bin/jq length`
    for ((api=0;api<$npeers;api++)) # a peer index
    do

	# a peer
	apr=`/usr/bin/echo $mypeers | \
             /usr/bin/jq -r ".[${api}].Address"  `
	aprip=`echo $apr | sed 's/:[0-9]*//'` #just the ip address
	#check connectivity to peer
	ncr=`echo yousuck | $nccmd -w $to $aprip $wp 2>/dev/null | grep -o -e weave`
	
        #interestingly the netcat probe returns 'weave'
	#if [ $? != 0 ] #wrks with the docker cmd
	if [ "${ncr}" != "weave" ] #since scanner opt not avail in ncat
	then
	    /opt/bin/weave forget $apr
	    echo $apr down. weave forgetting.
	else
	    echo $apr ok
	    :
	fi
    done
    sleep 10
done
 

