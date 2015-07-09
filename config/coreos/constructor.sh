#!/bin/sh

#wrapper around my cloud config thign

scriptDIR=$(dirname $0)
configwriterDIR=${scriptDIR}/../../cloudconfig-writer
configpy=${configwriterDIR}/constructor.py


python=/usr/bin/python #


$python $configpy ${1+"$@"}
