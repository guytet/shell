#!/bin/bash
# os_finder.sh called from and returns to install.sh

# we must determine Linux OS vendor, then version, first. 

# The *-release file containts multiple matches for "ID" across OS's. The grep being used
# seems like the best way to retrieve a simple OS name, the result would be e.g "ID=debian",
# "ID=centos" ,etc.

OS=$(cat /etc/*-release |grep "^ID=")

case "$OS" in 

"ID=debian" )
	echo "Debian is found"
	. bla.sh
;;


'ID="centos"' )
        echo "CentOS is found"
	. centos.sh
	exit 0;
;;

"ID=ubuntu" )
	echo "Ubuntu is found"
;;
	

* ) echo "search done, no supported OS was found, will now exit"
	  exit 0


esac

