#!/bin/sh

ansible-playbook -vvvv ec2.yml -e count=0 -e type=compute
ansible-playbook -vvvv ec2.yml -e count=0 -e type=gpu
