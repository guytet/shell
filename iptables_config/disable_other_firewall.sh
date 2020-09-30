#!/bin/bash

echo "checking for ufw installation";
systemctl status ufw >> /dev/null

case "$?"  in 

"4") echo "ufw isn't installed, skipping to next step" 
;;

"3") echo "ufw installed but not running, disabling ufw at boot"
     systemctl stop ufw >> /dev/null
     systemctl disable ufw  >> /dev/null 
;;

"0") echo ">>/dev/null found and running, stopping then disabling ufw at boot" 
     systemctl stop ufw >> /dev/null
     systemctl disable ufw >> /dev/null 
;;
esac


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
