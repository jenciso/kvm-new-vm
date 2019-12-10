#!/bin/sh

#### Variables
VM=$1
D=/data/vms
####

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

virsh shutdown $VM
virsh undefine $VM
virsh pool-destroy $VM
rm -rf $D/$VM
