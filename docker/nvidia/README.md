# CoreOS-Nvidia
This is a Dockerfile that builds a container with nvidia GPU drivers and CUDA.

It should be built on a machine running the same CoreOS version as the target machine (the one with the Nvidia card installed), if not the target machine itself.  Of course the container can only be run on a machine with Nvidia hardware installed.

## "Installation"

The purpose of the steps in this section is to load the NVIDIA drivers.

Build: `docker build -t nvidia github.com/majidaldo/coreos-nvidia`<br>
Run: `docker run --rm --privileged nvidia`<br>
You should see your NVIDIA harware printed.<br>
Confirm module is loaded: `lsmod | grep -i nvidia`<br>
You should see:
```
nvidia_uvm             77824  0
nvidia               8560640  1 nvidia_uvm
i2c_core               45056  3 i2c_i801,ipmi_ssif,nvidia
```

## Usage

To make use of CUDA in a docker container, you must recreate the installation environment in the container. The Dockerfile contains instructions to recreate the environment if it is used as a base for other images. Just insert `FROM nvidia` at the beginning of your CUDA application Dockerfile (You could also just modify the 'installation' Dockerfile itself or enter the installation container.). 

You can also use some  containerized CUDA-enabled applications built by others. As (a tested) example, you can run CUDA-enabled [Theano](https://github.com/Kaixhin/dockerfiles/blob/master/cuda-theano/cuda_v7.0/Dockerfile) if the `FROM` instruction is changed to `FROM nvidia`.

After building the CUDA application image, run it passing NVIDIA devices. [This](https://gist.github.com/majidaldo/87d6a4c58df07f69b269) script will generate a device list in a format suitable for use with `docker run` options. Is also creates NVIDIA devices on the host so it has to run with escalated privileges (sudo).
```
docker build -t cuda-app ./cuda-app
NV_DEVICES=$(sudo ./coreos-nvidia/devices/nvidia_devices.sh)
docker run -ti $NV_DEVICES cuda-app
```

You can start over just by removing the modules `sudo rmmod nvidia_uvm && sudo rmmod nvidia` and building again (`rmomod` might not be necessary since the driver installation removes the older driver but I haven't checked).


## Notes

There may be a better base image, and some post build cleanup that could be done to make the container smaller.

Currently the build uses `uname -r` to detect the running kernel version.  There maybe be a better way to do this that offers more flexibility.

[General Comments](http://msdresearch.blogspot.com/2015/08/run-cuda-applications-on-coreos.html)
