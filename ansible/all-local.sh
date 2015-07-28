#!/bin/sh

ansible-playbook -vvvv init.yml &
ansible-playbook -vvvv compute-local.yml &
wait
ansible-playbook -vvvv coreos-setup.yml -e coreos_config=compute



