#!/bin/bash

# rules.sh
# copies ./iptables.rules to /etc/iptables/
# as well as creating the up/down scripts for iptables and defining default policies. 

iptables -P INPUT  ACCEPT
iptables -P INPUT  ACCEPT
iptables -P INPUT  ACCEPT

echo -e "Starting to configure IPtables Firewall\n"; sleep 1;
echo -e "saving active rules to /etc/iptables/iptables.rules\n"; sleep 1

mkdir /etc/iptables
cp iptables.rules /etc/iptables/iptables.rules

echo -e "backing up current rules to /etc/iptables/iptables.rules.backup"
iptables-save > /etc/iptables/iptables.rules.backup
iptables-restore < /etc/iptables/iptables.rules

echo -e "Creating post-up and pre-down scripts, to load and save
IPtables on startup / shutdown\n"; sleep 1

cat << EOF > /etc/network/if-pre-up.d/iptablesload
#!/bin/sh
iptables-restore < /etc/iptables/iptables.rules
exit 0
EOF


cat << EOF > /etc/network/if-post-down.d/iptablessave
#!/bin/sh
iptables-save -c > /etc/iptables/iptables.rules
if [ -f /etc/iptables.downrules ]; then
iptables-restore < /etc/iptables.downrules
fi
exit 0
EOF

chmod +x /etc/network/if-post-down.d/iptablessave
chmod +x /etc/network/if-pre-up.d/iptablesload

echo "configuration done, will now exit"
exit 0;
