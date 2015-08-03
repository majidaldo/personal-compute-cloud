# CoreOS-based personal compute cloud
personal compute cloud using ansible (ansible-vagrant ( vagrant-python)) coreos, docker, vagrant, and weave.

## Prerequisites
- Linux: duh. windows users can use  (plain) cygwin. but i prefer babun.
- Ansible: tested with 1.9. works on windows with cygwin with setup/cygwin/install-myansible.sh
- python-vagrant
- Vagrant: windows users should install vagrant-winnfsd setup/install-vagrant.bat

## Project Environment Variables
config/project.env.sh

## Project Setup
run setup/setup.sh
kill winnfsd then start teh one in the base dir
