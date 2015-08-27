#!/bin/sh

ansible-playbook save-ec2.yml -e state=stopped -e type=gpu
ansible-playbook save-ec2.yml -e state=stopped -e type=cpu
