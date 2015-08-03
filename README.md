# CoreOS-based personal compute cloud
personal compute cloud using ansible (ansible-vagrant ( vagrant-python)) coreos, docker, vagrant, and weave.
## Why?
because scientific computing. link to explanation post.
## Features
## How it Works

## Prerequisites

- Linux: duh. windows users can use  (plain) cygwin. but i prefer babun.
- Ansible: tested with 1.9. works on windows with cygwin with setup/cygwin/install-myansible.sh
- python-vagrant
- Vagrant: windows users should install vagrant-winnfsd setup/install-vagrant.bat

## Project Environment Variables

config/project.env.sh

## Project Setup

go into config/project.env and change VARLIBDOCKER_GB to say 10 (GB)
add your dockerfiles like docker/999-mybusybox

run setup/setup.sh
kill winnfsd then start teh one in the base dir
