#!/bin/sh

#wrapper around my cloud config thign

scriptDIR=$(dirname $0)
configwriterDIR=${scriptDIR}/../cloudconfig-writer
configpy=${configwriterDIR}/constructor.py


python=/cygdrive/c/Anaconda/envs/cc/python


$python $configpy ${1+"$@"}
