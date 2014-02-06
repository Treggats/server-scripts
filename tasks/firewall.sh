#/usr/bin/env bash

HOME='mtonko.xs4all.nl'

echo "Setting rules"

iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain

# User defined chains for matching protocols
iptables -N TCP
iptables -N UDP

# No forwarding
iptables -P FORWARD DROP

# Don't filter outgoing traffic
iptables -P OUTPUT ACCEPT

# Drop all incomming traffic
iptables -P INPUT DROP

# Accept established/related traffic
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Accept local loopback interface
iptables -A INPUT -i lo -j ACCEPT

# Drop invalid traffic
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# Accept pings
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

# Attach TCP/UDP chains to INPUT chain
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

# Reject unreachable ports
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-rst
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

# SSH
iptables -A TCP -p tcp -s $HOME --destination-port 22 -j ACCEPT

# Webserver
iptables -A TCP -p tcp --destination-port 80 -j ACCEPT

# Block the spammers
iptables -N SSH_CHECK
iptables -A TCP -p tcp --dport 22 -m state --state NEW -j SSH_CHECK
iptables -A SSH_CHECK -m recent --set --name SSH
iptables -A SSH_CHECK -m recent --update --seconds 60 --hitcount 4 --name SSH -j DROP

# LOG the rest
iptables -A INPUT -j LOG --log-prefix "Firewall dropped: "

echo "Save firewall options"
iptables-save > /etc/iptables/iptables.rules

echo "Enable and start the firewall"
systemctl enable iptables
systemctl start iptables
