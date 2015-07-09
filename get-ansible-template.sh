#!/bin/sh
set -e

#setup
rm -fr ansible-temp
mkdir ansible || true
git clone --recursive git@github.com:majidaldo/ansible-vagrant.git ansible-temp

#get files
cd ansible-temp
git checkout template
git checkout master $(cat files.txt)

#copy over
#force overwrite
#cp -rf $(cat files.txt) ../ansible
#only files that don't exist. -u doesn't do the job
yes n | cp -r $(cat files.txt) ../ansible
rm -rf $(find ../ansible -name .git)

#clean up
cd ..
rm -fr ansible-temp
