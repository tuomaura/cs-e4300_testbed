#!/usr/bin/env bash

## Traffic going to the internet
route add default gw 172.30.30.1

## Currently no NAT 
#iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6
