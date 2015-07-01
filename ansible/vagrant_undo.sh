#!/bin/sh

#undo effect of adding a box

set -e

cd ../providers/vagrant/${1}
vagrant destroy -f 
cd ../../../ansible


cd .vagrant
vagrant destroy -f $1
cd ..

vagrant box remove  $1 -f || true


#rm -r .vagrant
#mkdir .vagrant

rm ../../tsad-bigfiles/images/vagrant/$1
