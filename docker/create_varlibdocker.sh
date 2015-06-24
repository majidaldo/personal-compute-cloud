#!/bin/sh

#creates a block device from file(s) on the fs

vldf=/tsad-proj/tsad-bigfiles/images/docker/varlibdocker
#todo to generalize make variable out of /home/core/vld
#and /dev/varlibdocker

gb=10
start=0

    #!
if [  ! -d "$vldf" ];
then
    mkdir $vldf
    atfs=${RANDOM}.tmp
    #1GB
    #put it in local then cpy
    dd if=/dev/zero of=$atfs bs=1M count=1000
    for (( i=$start; i<$gb; i++ )); do
	cp $atfs ${vldf}/$i.fs
	echo ${i}.fs
    done
    rm $atfs
    #not block devices gives errors. ignore the errors ok??
    #sudo mkfs.btrfs  -L vld -m single $(ls ${vldf}/*.fs )
#else

fi


sudo losetup -f #idk why this 'triggers' /dev/loopX
devlist_file=${vldf}/dev.list


assign_dev () {
sudo losetup -d $(cat $devlist_file)
sudo rm -f $devlist_file | :
for afs in $(ls -1 ${vldf}/*.fs ); do
    loopdevice=$(losetup -f)
    echo assigning $afs loopback device at $loopdevice
    sudo losetup $loopdevice $afs
    echo -n ${loopdevice} >> $devlist_file
    echo -n ' ' >> $devlist_file
done
devlist=( $(cat $devlist_file) )
sudo rm -f /dev/varlibdocker
sudo ln -s ${devlist[0]} /dev/varlibdocker
}



assign_dev
#sudo mkdir /var/lib/docker | :
sudo mkfs.btrfs  -L vld -m single $(cat $devlist_file)


#the scan is important! as per  btrfs wiki
mkdir /home/core/vld
sudo btrfs device scan
sudo mount -v /dev/varlibdocker /home/core/vld

echo printing mounts just so you can see the mount  didnt work
mount

#going through the following crap bc sometimes it doesnt mount
#even if i had previously formatted and mounted successfully

if mountpoint -q /home/core/vld
then
    echo mounted
else
    echo crap! not mounted. some problem causd by idk what.
    echo making nonsense mounts to try to fix
    sudo mount -v -o ro,recovery /dev/varlibdocker /home/core/vld
    sudo umount -v /home/core/vld
    assign_dev
    sudo mount -v /dev/varlibdocker /home/core/vld
    #chk again
    if mountpoint -q /home/core/vld
    then
	echo idk that worked
    else
	echo more drastic measures
	#do i really need to loop thru devs here
	for afs in $(ls -1 ${vldf}/*.fs ); do
	    sudo btrfs check --repair $afs
	done
	assign_dev
	sudo mount -v /dev/varlibdocker /home/core/vld
    fi
fi

echo done mnt script