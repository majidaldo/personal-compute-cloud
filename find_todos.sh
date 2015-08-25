#!/bin/sh

source ./common.src

pf=$(basename `$ENVCMD PROJECT_FILES`)
files=$(find ./ -type f \
	     -not -path "./files/*" \
	     -not -path "*/.git/*" \
	     -not -path "*.tmp" \
#	     -not -path "./find_todos.sh*" \
     )
#todo: just use exclusion cmd in grep cmd directly

for af in $files
do

    matches=`cat $af | grep -n -B 5 -A 5 'todo' --color=always`
    if [ "$matches" != "" ]
    then
	echo $af------
	echo
	printf "$matches"
	echo
	echo -------------------------------
	echo
	echo
    fi

done
