#!/bin/bash
#this file is being called from, and returns to ./install.sh

systemctl stop firewalld > /dev/null
systemctl disable firewalld > /dev/null
