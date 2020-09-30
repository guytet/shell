#!/bin/bash
#install.sh

#sets up IP tables on 
#Ubutnu 14.04,  16.04
#CentOS 7
#Debian 8

#ssh connection inbound allowed, as well as ping

#writes iptables config to /etc/iptables/iptables.rules
#adds boot/shutdown scripts in order for settings to stay persistent. 

#user input is required 
#*******************************#

#Begin user interaction

#Are we root ?  
if [ ! $(id -u) = 0 ]; then
	echo -e "you are not root, run this script as root or sudo\n"
	exit
fi

# something might be fishy if /etc/ipatbles exists, we're quiting. 
if [ -d /etc/iptables ] ; then
cat <<EOF

/etc/iptables exists, this script *will*
overwrite it, please check and rename/remove
/etc/iptables, then re-run ./install.sh
will now exit
EOF
exit 0;
fi

#check for distro, match: execute ./check_linux, no match: exit. 
./os_finder.sh	

# Warnings warnings and more warnings. 

# Make sure we're at the local console
echo
read -p "WARNING-- this script should not be run remotely, 
(e.g over ssh), networking may be lost if wrong answers would be provided during this script,
proceed? y/n ?  " -n 1 ANSWER ;

	if [[ ! $ANSWER == y ]]; then 
		exit 
	fi
echo

# Make sure we're not running this from network mount
read -p "This script cannot be run as a network user(ssh), or from a network share.  
unless physical access is available to restore network if this script breaks it.
enter 'y' to continue " -n 1 ANSWER

	if [ ! $ANSWER == y ];then 
		exit
	fi
echo

# All set, one more user input and done
echo "ready to install"
while true; 
do
	
read -p "press 1 to start 2 to exit  " ANSWER
	
case $ANSWER in

"1")
	./os_finder.sh
	break
;;		

"2")
        exit 0;
;;        
	
*)	echo "You have not provided a valid choice";
;;
  esac

done
