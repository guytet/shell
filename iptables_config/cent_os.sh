#!/bin/bash


#cent_os.sh: This script gets called by os_finder.sh
#This part will take care of cent_os firwewalld stopping, disabling
#installing iptables, and having the correct rules in place. 


echo "checking for or firewalld installation";
systemctl status firewalld >> /dev/null

case "$?"  in

"4") echo "firewalld isn't installed, skipping to next step"
;;

"3") echo "firewalld installed but not running, disabling firewalld at boot"
     systemctl stop firewalld >> /dev/null
     systemctl disable firewalld  >> /dev/null
;;

"0") echo "firewalld found and running, stopping then disabling firewalld at boot"
     systemctl stop firewalld >> /dev/null
     systemctl disable firewalld >> /dev/null
;;
esac

yum -y install iptables-services
systemctl enable iptables.service
systemctl start iptables.service

echo "iptables service has been installed and enabled"
sleep 1

echo "configuration for CentOS is complete"
iptables -L -n
