# iptables_config

To install run ./install.sh

Will disable ufw and firewalld on systems that ship with it, and re-enable iptables,
while opening only ssh(22) and icmp echo (ping) new traffic inbout. 

Configures ports:
Enabled: 22(ssh incoming), icmp echo (ping).
Disabled: All the rest. 

Currently supports: Ubuntu Bionic and Xenial, CentOS 7, and Debian 8. 
