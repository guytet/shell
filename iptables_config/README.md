# iptables_config

Really, this is not productive. firewalld is awesome, (and ufw is not).  
(But sometimes, only sometimes, straight up mean ole' iptables is needed, and nothing else). 

To install run ./install.sh

Will disable ufw and firewalld on systems that ship with it, and re-enable iptables,
while opening only ssh(22) and icmp echo traffic inbound. 

Currently supports: Ubuntu Bionic and Xenial, CentOS 7, and Debian 8. 
And will never support anything newer, because firewalld is awesome, (and.. ufw is not).  
