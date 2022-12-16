#!/usr/bin/env bash

# Set iptables-persistent
sudo debconf-set-selections <<EOF
iptables-persistent iptables-persistent/autosave_v4 boolean true
iptables-persistent iptables-persistent/autosave_v6 boolean true
EOF

# Install and upgrade
apt-get update -y --fix-missing
apt-get install -f
apt-get -y dist-upgrade

# Install tools for networking
sudo apt-get install  -y dialog debconf-utils apt-utils iputils-ping iptables iputils-tracepath traceroute netcat conntrack nmap wget rsync iptables-persistent > /dev/null

# Enable ipv4 forwarding
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
# Other ipsec settings
sudo echo "net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf

sudo sysctl -p /etc/sysctl.conf

# Install IPsec tools
sudo apt-get install -y strongswan moreutils libstrongswan-extra-plugins > /dev/null



# Install libs
sudo apt-get install -y net-tools locate vim nano tcpdump dnsutils traceroute curl git-core bzip2 conntrack  > /dev/null

# Add node16 repository
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
sudo apt-get install -y nodejs 