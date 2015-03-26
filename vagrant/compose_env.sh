#!/bin/sh

#development specific env vars are "overwritten" when sourced
#b/c they come after
CATENVS="cat ../env ./env | sed -e '/\s*#.*$/d' -e '/^\s*$/d'"
#thank yoouuu
#http://stackoverflow.com/questions/3350223/sed-remove-and-empty-lines-with-one-sed-command



if [ "$1" = "export" ]
then
    eval $CATENVS "| sed -e 's/^/export /'"
else
    eval $CATENVS
fi
