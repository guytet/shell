#!/bin/bash

users=$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)
root_dir="/tmp/keys"


for user in ${users[@]}; do
 sudo mkdir -p $root_dir/$user
 sudo cp "/home/$user/.ssh/authorized_keys" "$root_dir/$user/$user.keys"
 [[ $? -eq 0 ]] && echo "copied /home/$user/.ssh/authorized_keys to $root_dir/$user/$user.keys"
done
