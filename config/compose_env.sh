#!/bin/sh

#use: thisscirpt.sh envfile1 env2 env3 [export]


for lastarg; do true; done
if [ "$lastarg" = "export" ]
then
    #cat all the args except the last
    catargs=${@:1:$(($# - 1))}
else
    catargs=${1+"$@"}
fi

#development specific env vars are "overwritten" when sourced
#b/c they come after
CATENVS="cat ${catargs} | sed -e '/\s*#.*$/d' -e '/^\s*$/d'"
#thank yoouuu
#http://stackoverflow.com/questions/3350223/sed-remove-and-empty-lines-with-one-sed-command



if [ "$lastarg" = "export" ]
then
    eval $CATENVS "| sed -e 's/^/export /'"
else
    eval $CATENVS
fi
