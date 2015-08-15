#!/bin/sh


# todo: remove ec2inst dependence on ec2setup?
# so that when i destroy i dont have to exec ec2setup

ansible-playbook -vvvv ec2.yml -e count=0 -e type=compute
ansible-playbook -vvvv ec2.yml -e count=0 -e type=gpu
