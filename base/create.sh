#!/bin/sh

vagrant destroy -f base
vagrant box remove base
vagrant up base --provision
vagrant vbguest base --status	
vagrant package --output ../base.box
vagrant box add base ../base.box -f
vagrant destroy -f base
rm -rf .vagrant/
