#!/bin/sh

#prereqs
pact install python python-paramiko python-crypto gcc-g++ wget openssh python-setuptools
python /usr/lib/python2.7/site-packages/easy_install.py pip

#/usr/bin/pip install ansible
#cd ..
#git clone --recursive --depth 1 https://github.com/ansible/ansible.git
#cd ansible
#source ./hacking/env-setup
pip install git+https://github.com/ansible/ansible@devel --upgrade
#pip install git+https://github.com/ansible/ansible@stable-1.9 --upgrade
#pip install ansible==1.9.2
#sudo ./install-myansible.sh

/usr/bin/pip install boto --upgrade
/usr/bin/pip install python-vagrant --upgrade
#vagrant wants this on windows
/usr/bin/pip install lockfile --upgrade

