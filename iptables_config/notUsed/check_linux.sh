#!/bin/bash
#this file is being called from, and returns to ./install.sh

if [ -f /etc/redhat-release ]; then
	
	exit 3;

else
	output=$(lsb_release -rs)
	if [ "$output" == "14.04" ]; then
 		exit 1;
	elif
	    [ "$output" == "16.04" ]; then 
		exit 1;

	elif [[ $output == *"8"* ]] ; then

		exit 1;

	elif [ $output ==  "stretch" ]; then
		exit 1;

	fi
fi
