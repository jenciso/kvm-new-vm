#!/bin/sh

#### Variables
VM=centos7
D=/data/vms
####

virsh shutdown $VM
virsh undefine $VM
virsh pool-destroy $VM
rm -rf $D/$VM
