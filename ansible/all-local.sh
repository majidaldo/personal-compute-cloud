#!/bin/sh

destroy=${1-dontdestroy}

if [ $destroy = "destroy" ]; then
   ./destroy-vagrant.sh
fi

ansible-playbook -vvvv init.yml &
ansible-playbook -vvvv vagrant.yml &
wait
ansible-playbook -vvvv setup.yml -e hosts=vagrant



