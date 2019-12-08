## KVM new vm

Download the qcow2 cloud image

```
wget http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2 \
  -O /var/lib/libvirt/boot/CentOS-7-x86_64-GenericCloud.qcow2 
```

Modify the new-vm.sh

