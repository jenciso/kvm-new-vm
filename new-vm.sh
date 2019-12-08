#!/bin/sh

D=/data/vms
VM=punto8
DISK_SIZE=20G
IPADDR=10.253.253.63

export VM=$VM
export IPADDR=$IPADDR

envsubst < user-data.src > user-data
envsubst < meta-data.src > meta-data

virsh pool-destroy $VM

mkdir $D/$VM
cp /var/lib/libvirt/boot/CentOS-7-x86_64-GenericCloud.qcow2 $D/$VM/$VM.qcow2

export LIBGUESTFS_BACKEND=direct
qemu-img create -f qcow2 -o preallocation=metadata $D/$VM/$VM.new.image $DISK_SIZE
virt-resize --quiet --expand /dev/sda1 $D/$VM/$VM.qcow2 $D/$VM/$VM.new.image
mv -f $D/$VM/$VM.new.image $D/$VM/$VM.qcow2

mkisofs -o $D/$VM/$VM-cidata.iso -V cidata -J -r user-data meta-data
rm -f user-data meta-data

virsh pool-create-as --name $VM --type dir --target $D/$VM

virt-install --import --name $VM \
--memory 1024 --vcpus 1 --cpu host \
--disk $D/$VM/$VM.qcow2,format=qcow2,bus=virtio \
--disk $D/$VM/$VM-cidata.iso,device=cdrom \
--network bridge=virbr0,model=virtio \
--os-type=linux \
--os-variant=centos7.0 \
--graphics spice \
--noautoconsole

virsh autostart $VM
