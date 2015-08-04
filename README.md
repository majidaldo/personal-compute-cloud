# CoreOS-based personal compute cloud
personal compute cloud using ansible (ansible-vagrant ( vagrant-python)) coreos, docker, vagrant, and weave.

## Why?
because scientific computing. link to explanation post.

## Features
There is a controller machine prividing coordination and services; and compute machines that are more ephemeral. A local compute machine is brought up for 'development'. But when a remote compute machine is acquired, it would use the same (ansible) setup script. The controller and compute machines together provide:
- global network addressing of docker containers across clouds (thanks to weave)
- private docker registry accessible on all compute hosts (started on boot)
- automatic building of Dockerfiles and pushing them to the registry (on boot)
- global NFS fileshare .. no messing with sending and receiving files 
- docker images persist over instantiations of the controller machine
- ssh access to machines is automatically configured.

small print: claims of globally accessible services have not been tested. but the configuration is there for it to happen.

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
