#!/bin/bash

# If ufw is present, disable it.
# dpkg-query -l ufw > /dev/null returns "0" if ufw is found.

echo -e "checking to see if ufw is installed\n"
	
	dpkg-query -l ufw > /dev/null

	if [[ "$?" == 0 ]]; then
	echo -e "found ufw firewall manager, disabling it\n"
	/usr/sbin/ufw disable > /dev/null
        else echo -e "did not find ufw, proceeding..\n"
	fi

