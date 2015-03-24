#!/bin/sh



SRCSRC=$1

#dev mode gets files from mounted dir
if [ "$SRCSRC" = "dev" ]
then
    ln -s /tsad-proj /src
#otherwise get them from the repo
else
    git clone https://github.com/majidaldo/tsad.git
    mv tsad /src 
fi

