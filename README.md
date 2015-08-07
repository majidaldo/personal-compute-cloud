# CoreOS-based personal compute cloud
personal compute cloud using [Ansible](http://www.ansible.com), [CoreOS](http://www.coreos.com),  [Docker](http://www.docker.com), [Vagrant](http://www.vagrantup.com), and [weave](http://weave.works).

## Why?
because scientific computing. link to explanation post.

## What it Does
Two types of machines are started to support the scientific computing workflow (using Docker). There is a local virtualized controller machine (called init) prividing coordination and services; and compute machines that are more ephemeral. A local compute machine is brought up for 'development'. But when a remote compute machine is acquired, it would use the same (ansible) setup script (untested). Therefore, the local compute machine is really a stand-in for a remote machine. The controller and compute machines together provide:

## Features
- global network addressing of docker containers across clouds (thanks to weave)
- private docker registry accessible on all compute hosts (started on boot)
- automatic building of Dockerfiles and pushing them to the registry (on boot)
- global NFS fileshare .. no messing with sending and receiving files 
- ssh access to machines is automatically configured.

small print: claims of globally accessible services have not been tested. but the configuration is there for it to happen.

## Prerequisites

- Linux: duh. windows users can use  (plain) [`cygwin`](http://www.cygwin.com). but i prefer [`babun`](http://babun.github.io). 
- Ansible: tested with 1.9. works on windows with cygwin with `setup/cygwin/install-myansible.sh`
- python-vagrant
- Vagrant: windows users should install vagrant-winnfsd setup/install-vagrant.bat. kill the winnfs.exe process if you have nfs mounting issues

## Setup

*Variables*

Project variables are located in `.env` files in the `config/` folder. There is no immediate need for changing these variables as I tried to make everything as automatic and reasonable as possible. You may want to remove the line `control_path = /tmp` in `ansible/ansible.cfg` as it is a cygwin hack.

*Dockerfiles*

So all you have to do is add your Dockerfiles in the `docker/` folder like `docker/999-mybusybox`. The build script will only build folders that start with an number followed by a hyphen, in order. Make use of this behavior to satisfy Docker image dependencies.

*Initialization*

Run `setup/setup.sh` from within its directory.


## Usage

Start up the virtual machines by running `ansible/all-local.sh` from within its directory. Now you can `ssh init` or `ssh compute-local`. `$REGISTRY_HOST` is a variable on all machines to access the private docker registry like `docker pull $REGISTRY_HOST/myimg`.



