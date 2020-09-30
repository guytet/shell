#!/bin/bash

# VM backup for kvmhost machines. Usage ./vm_backup [vm name]
# Differs from vm_backup.sh by only suspending ("pause") the VM instead of full shutdown

#This script *relies* on naming scheme of *.img, VM images with different suffix will fail 
#unless this scripts is modified. 

# Runs for machines which may be more sensitive for a full shutdown: i.e machine with processes 
# which may not start automatically after reboot, machines where starting up applications
# after a full reboot may need manual intervention, and Windows machines. 

# Marked with ***** = needs admin updating per the server this is running on.
#-----------------------------------------------------------------------------#

# VM name
ARG1=$1

mail_to="" #*****

rsync_cmd="/usr/bin/rsync -avr --address"

interface_ip="" #*****  #on machines with >1 interface, specify the best local IP to use.

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


#start vm after backup has finished
virsh resume $ARG1
}

# entrypoint
# loop twice:send suspend signal to VM, wait for 30 seconds for suspend,

for((i=0; i<2; i++))
do

        virsh suspend $ARG1
        sleep 10
        virsh list  --state-paused |grep  $ARG1

                if [ $? == 0 ]; then  
                        backup_vm
                        checkup  
                        exit
                fi
done

# if while() did not succeed, send this:

mail -s "Backup message from $HOSTNAME" -r $HOSTNAME $mail_to<<EOF
VM $ARG1 could not be shutdown for backup,on host $HOSTNAME, 
backup did not succeed
EOF
