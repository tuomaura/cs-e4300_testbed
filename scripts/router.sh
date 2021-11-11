#!/usr/bin/env bash

#############################################################
# Please do not modify this file. The router simulates the  #
# public Internet and is not something you can reconfigure. #
#############################################################

## NAT traffic going to the internet, TODO: don't use the Vagrant ssh interface
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE

## Route 172.30.0.0/16 all via gateway-s
route add -net 172.48.48.48 netmask 255.255.255.240 gw 172.30.30.30 enp0s8

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6
