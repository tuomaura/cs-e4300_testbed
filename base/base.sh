#!/usr/bin/env bash

# Enable ipv4 forwarding
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
# Other ipsec settings
sudo echo "net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf

sudo sysctl -p /etc/sysctl.conf

# Install tools for networking
sudo apt-get -y install dialog debconf-utils apt-utils iputils-ping iptables\
  iputils-tracepath traceroute netcat conntrack nmap wget rsync

# Install IPsec tools
sudo apt-get -y install strongswan moreutils libstrongswan-extra-plugins

# Install iptables-persistent
sudo echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
sudo echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y iptables-persistent

# Install libs
sudo apt-get install -y net-tools locate vim nano tcpdump dnsutils traceroute\
  curl git-core bzip2 npm nodejs conntrack
