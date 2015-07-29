#!/bin/sh

destroy=${1-dontdestroy}

if [ $destroy = "destroy" ]; then
   ./destroy-vagrant.sh
fi

ansible-playbook -vvvv init.yml &
ansible-playbook -vvvv compute-local.yml &
wait
ansible-playbook -vvvv coreos-setup.yml -e coreos_hosts=compute-local* -e coreos_config=compute



