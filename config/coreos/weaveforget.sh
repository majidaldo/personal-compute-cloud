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
    #status is only app up to Reconn section
    peers=`/opt/bin/weave status | /usr/bin/sed -e 's/Peers:\(.*\)Reconnects:/\1/' | /usr/bin/pcregrep -o -e $re`
    #echo $peers; exit
    for apr in $peers
    do
	#check connectivity to peer
	ncr=`echo yousuck | $nccmd -w $to $apr $wp 2>/dev/null | grep -o -e weave`
        #interestingly the netcat probe returns 'weave'
	#if [ $? != 0 ] #wrks with the docker cmd
	if [ "${ncr}" != "weave" ] #since scanner opt not avail in ncat
	then
	    weave forget $apr
	    echo $apr down. weave forgetting.
	else
	    #echo $apr ok
	    :
	fi
    done
    sleep 10
done
 

