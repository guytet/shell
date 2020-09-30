#!/bin/bash

# VM backup for kvmhost machines. Usage ./vm_backup_by_shutdown.sh [vm name]

# This script *relies* on a naming scheme of *.img, VM images with different suffix will fail 
# unless this scripts is modified. 

# Marked with ***** = needs admin updating per the server this is running on.

#-----------------------------------------------------------------------------#

# VM name
ARG1=$1

mail_to="" 

rsync_cmd="/usr/bin/rsync -avr --address"

#on machines with >1 interface, specify the best local IP to use.
interface_ip=""  

source_dir="/kvm/main_storage"
target_dir="/backup/current_backup"

source_file=$source_dir/$ARG1.img
target_file=$target_dir/$ARG1.img

stat_cmd="/usr/bin/stat --format %s"

# Functions

function backup_vm 
{
        mv -f $target_dir/$ARG1.img $target_dir/$ARG1.previous.img
        $rsync_cmd $interface_ip $source_file $target_dir
}

# checkup and VM resume

function checkup 
{
if [ ! -f $target_file ];then

mail -r $HOSTNAME  -s "Backup message from $HOSTNAME" $mail_to<<EOF
backup script was run, but actual $ARG1.img file
could not be found on
/backup/current_backup/, please check
EOF

elif [[ ! $($stat_cmd $source_file) == $($stat_cmd $target_file) ]]
then
mail -r $HOSTNAME  -s "Backup message from $HOSTNAME" $mail_to<<EOF
backup script was run, but actual $ARG1.img source and
copy are not the same size,please check
EOF
fi

# after backup has finished
virsh start $ARG1
}

# entrypoint

# loop twice:send shutdown signal to VM, wait for 45 seconds
for((i=0; i<2; i++))
do

        virsh shutdown $ARG1
        sleep 45
	virsh list |grep $ARG1
                if [ $? == 1 ]; then  
                        backup_vm
                        checkup 
                        exit 0
                fi
done

# if while() did not succeed:

mail -s "Backup message from $HOSTNAME" -r $HOSTNAME $mail_to<<EOF
VM $ARG1 could not be shut down for backup, on kvm host $HOSTNAME, 
backup did not succeed
EOF
