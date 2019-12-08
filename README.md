## KVM new vm

Download the qcow2 cloud image

```
wget http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2 \
  -O /var/lib/libvirt/boot/CentOS-7-x86_64-GenericCloud.qcow2 
```

Modify the new-vm.sh and run it
```
./new-vm.sh
```

Post install
```
virsh change-media $VM hda --eject --config
rm -f $D/$VM/$VM-cidata.iso
```

To delete vm
```
./delete-vm.sh
```
