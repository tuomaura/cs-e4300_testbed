#!/usr/bin/env bash

## Traffic going to the internet
route add default gw 172.48.48.49

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

## Install app
cd /home/vagrant/server_app
npm install

