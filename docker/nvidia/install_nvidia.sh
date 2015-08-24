#!/bin/sh
set -e

mkdir -p /usr/src/kernels
cd       /usr/src/kernels

#get kernel source. recent CoreOS build from plain
#kernel source. that's why this works

curl https://www.kernel.org/pub/linux/kernel/\
v`uname -r | grep -o '^[0-9]'`.x/\
linux-`uname -r | grep -o '[0-9].[0-9].[0-9]'`.tar.xz \
    > linux.tar.xz
mkdir linux
tar -xvf linux.tar.xz -C linux --strip-components=1

#prepare source for modules

cd linux
zcat /proc/config.gz > .config
make modules_prepare
echo "#define UTS_RELEASE \"$(uname -r)\"" \
    > include/generated/utsrelease.h


# Nvidia drivers setup

cd /opt/nvidia

if [ "$DRIVER_VER" = "CUDA" ];
then
    chmod +x ./cuda.run
    ./cuda.run \
	--silent \
	--driver \
	--kernel-source-path=/usr/src/kernels/linux
else
    chmod +x driver.run
    ./driver.run \
	--silent \
	--kernel-source-path=/usr/src/kernels/linux
fi
modprobe nvidia
#todo: install with --compat32-libdir?


# Nvidia CUDA setup

chmod +x cuda.run
./cuda.run --silent --toolkit --samples

# run samples setup

cd /usr/local/cuda/samples/1_Utilities/deviceQuery
make
./deviceQuery
