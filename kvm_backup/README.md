# kvm_backup
Intended for use on KVM host machines. Two options: one with sending a "shutdown" signal to a VM, the other with sending a "pause" signal. 

If your machine image file are suffixed with *.qcow or *.raw - you'll need to edit the script. 
Just look for $ARG1.img and change the "img" to the suffix you're using locally. 

The scripts have been tested under crontab (which likes to die due to perm's passed to it or lack thereof ), 
,all worked out well. 
