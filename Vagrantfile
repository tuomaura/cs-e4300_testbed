# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV["LC_ALL"] = "en_US.UTF-8"

## Documentation for VirtualBox-specific features:
# https://www.vagrantup.com/docs/providers/virtualbox/networking
# VirtualBox networking: https://www.virtualbox.org/manual/ch06.html
# modifyvm command: https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm

Vagrant.configure("2") do |config|

  #######################
  ## Internet          ##
  #######################

  ## Router
  config.vm.define "router" do |router|
    router.vm.box = "base"
    router.vm.hostname = "router"
    router.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards Gateway S 
    router.vm.network "private_network",
      ip: "172.30.30.1",
      netmask: "255.255.255.0",
      virtualbox__intnet: "isp_link_s"
    # Interface towards Gateway A 
    router.vm.network "private_network",
      ip: "172.16.16.1",
      netmask: "255.255.255.0",
      virtualbox__intnet: "isp_link_a"
    # Interface towards Gateway B 
    router.vm.network "private_network",
      ip: "172.17.17.1",
      netmask: "255.255.255.0",
      virtualbox__intnet: "isp_link_b"
    router.vm.provider "virtualbox" do |vb|
      vb.name = "router"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.111.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 256
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Install dependencies and define the NAT
    router.vm.provision :shell, run: "always", path: "scripts/router.sh"
  end

  #######################
  ## Customer site A   ##
  #######################

  ## Gateway A
  config.vm.define "gateway-a" do |gateway_a|
    gateway_a.vm.box = "base"
    gateway_a.vm.hostname = "gateway-a"
    gateway_a.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards router
    gateway_a.vm.network "private_network",
      ip: "172.16.16.16",
      netmask: "255.255.255.0",
      virtualbox__intnet: "isp_link_a"
    # Interface towards customer site network
    gateway_a.vm.network "private_network",
      ip: "10.1.0.1",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_a"
    gateway_a.vm.provider "virtualbox" do |vb|
      vb.name = "gateway-a"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.112.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 256
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Install dependencies and define the NAT
    gateway_a.vm.provision :shell, run: "always", path: "scripts/site_a_gateway.sh"
  end

  # Local server A
  config.vm.define "server-a" do |server_a|
    server_a.vm.box = "base"
    server_a.vm.hostname = "server-a"
    server_a.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards customer site network
    server_a.vm.network "private_network",
      ip: "10.1.0.99",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_a"
    server_a.vm.provider "virtualbox" do |vb|
      vb.name = "server-a"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.113.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Server app
    server_a.vm.provision :file, source: './apps/server_app',
      destination: "server_app"
    # Install dependencies and define the NAT
    server_a.vm.provision :shell, run: "always", path: "scripts/local_server.sh"
  end

  # Client A1
  config.vm.define "client-a1" do |client_a1|
    client_a1.vm.box = "base"
    client_a1.vm.hostname = "client-a1"
    client_a1.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards customer site network
    client_a1.vm.network "private_network",
      ip: "10.1.0.2",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_a"
    client_a1.vm.provider "virtualbox" do |vb|
      vb.name = "client-a1"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.114.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Client app
    client_a1.vm.provision :file, source: './apps/client_app',
      destination: "client_app"
    # Install dependencies and define the NAT
    client_a1.vm.provision :shell, run: "always", path: "scripts/client.sh"
  end

  # Client A2
  config.vm.define "client-a2" do |client_a2|
    client_a2.vm.box = "base"
    client_a2.vm.hostname = "client-a2"
    client_a2.vbguest.auto_update = false

    ## NETWORK INTERFACES
    # Interface towards customer site network
    client_a2.vm.network "private_network",
      ip: "10.1.0.3",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_a"
    client_a2.vm.provider "virtualbox" do |vb|
      vb.name = "client-a2"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.115.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Client app
    client_a2.vm.provision :file, source: './apps/client_app',
      destination: "client_app"
    # Install dependencies and define the NAT
    client_a2.vm.provision :shell, run: "always", path: "scripts/client.sh"
  end

  #######################
  ## Customer site B   ##
  #######################

  ## Gateway B
  config.vm.define "gateway-b" do |gateway_b|
    gateway_b.vm.box = "base"
    gateway_b.vm.hostname = "gateway-b"
    gateway_b.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards router
    gateway_b.vm.network "private_network",
      ip: "172.17.17.17",
      netmask: "255.255.255.0",
      virtualbox__intnet: "isp_link_b"
    # Interface towards customer site network
    gateway_b.vm.network "private_network",
      ip: "10.1.0.1",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_b"
    gateway_b.vm.provider "virtualbox" do |vb|
      vb.name = "gateway-b"
      vb.customize ["modifyvm", :id, "--groups", "/vpn"]
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.116.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 256
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Install dependencies and define the NAT
    gateway_b.vm.provision :shell, run: "always", path: "scripts/site_b_gateway.sh"
  end

  # Local server B
  config.vm.define "server-b" do |server_b|
    server_b.vm.box = "base"
    server_b.vm.hostname = "server-b"
    server_b.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards customer site network
    server_b.vm.network "private_network",
      ip: "10.1.0.99",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_b"
    server_b.vm.provider "virtualbox" do |vb|
      vb.name = "server-b"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.117.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Server app
    server_b.vm.provision :file, source: './apps/server_app',
      destination: "server_app"
    # Install dependencies and define the NAT
    server_b.vm.provision :shell, run: "always", path: "scripts/local_server.sh"
  end

  # Client B1
  config.vm.define "client-b1" do |client_b1|
    client_b1.vm.box = "base"
    client_b1.vm.hostname = "client-b1"
    client_b1.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards customer site network
    client_b1.vm.network "private_network",
      ip: "10.1.0.2",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_b"
    client_b1.vm.provider "virtualbox" do |vb|
      vb.name = "client-b1"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.118.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Client app
    client_b1.vm.provision :file, source: './apps/client_app',
      destination: "client_app"
    # Install dependencies and define the NAT
    client_b1.vm.provision :shell, run: "always", path: "scripts/client.sh"
  end

  # Client B2
  config.vm.define "client-b2" do |client_b2|
    client_b2.vm.box = "base"
    client_b2.vm.hostname = "client-b2"
    client_b2.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards customer site network
    client_b2.vm.network "private_network",
      ip: "10.1.0.3",
      netmask: "255.255.0.0",
      virtualbox__intnet: "intranet_b"
    client_b2.vm.provider "virtualbox" do |vb|
      vb.name = "client-b2"
      vb.customize ["modifyvm", :id, "--groups", "/vpn"]
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.119.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Client app
    client_b2.vm.provision :file, source: './apps/client_app',
      destination: "client_app"
    # Install dependencies and define the NAT
    client_b2.vm.provision :shell, run: "always", path: "scripts/client.sh"
  end

  ##########################
  # Cloud network S       ##
  ##########################

  #################################################################
  # Students: Ok to modify the IP addresses in the cloud network ##
  #################################################################

  
  # Gateway S
  config.vm.define "gateway-s" do |gateway_s|
    gateway_s.vm.box = "base"
    gateway_s.vm.hostname = "gateway-s"
    gateway_s.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards router
    gateway_s.vm.network "private_network",
      ip: "172.30.30.30",
      netmask: "255.255.255.0",
      virtualbox__intnet: "isp_link_s"
    # Interface towards server network
    gateway_s.vm.network "private_network",
      ip: "172.48.48.49",
      netmask: "255.255.255.240",
      virtualbox__intnet: "cloud_network_s"
    gateway_s.vm.provider "virtualbox" do |vb|
      vb.name = "gateway-s"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.120.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 256
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Install dependencies and define the NAT
    gateway_s.vm.provision :shell, run: "always", path: "scripts/cloud_s_gateway.sh"
  end

  # Cloud server S1
  config.vm.define "server-s1" do |server_s1|
    server_s1.vm.box = "base"
    server_s1.vm.hostname = "server-s1"
    server_s1.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards clouser server network
    server_s1.vm.network "private_network",
      ip: "172.48.48.51",
      netmask: "255.255.255.240",
      virtualbox__intnet: "cloud_network_s"
    server_s1.vm.provider "virtualbox" do |vb|
      vb.name = "server-s1"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.121.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Server app
    server_s1.vm.provision :file, source: './apps/server_app',
      destination: "server_app"
    # Install dependencies and define the NAT
    server_s1.vm.provision :shell, run: "always", path: "scripts/cloud_server.sh"
  end

  # Cloud server S2
  config.vm.define "server-s2" do |server_s2|
    server_s2.vm.box = "base"
    server_s2.vm.hostname = "server-s2"
    server_s2.vbguest.auto_update = false
    ## NETWORK INTERFACES
    # Interface towards server network
    server_s2.vm.network "private_network",
      ip: "172.48.48.52",
      netmask: "255.255.255.240",
      virtualbox__intnet: "cloud_network_s"
    server_s2.vm.provider "virtualbox" do |vb|
      vb.name = "server-s2"
      # Change the default Vagrant ssh address
      vb.customize ['modifyvm', :id, '--natnet1', '192.168.122.0/24']
      # Performance
      vb.cpus = 1
      vb.memory = 512
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    # Server app
    server_s2.vm.provision :file, source: './apps/server_app',
      destination: "server_app"
    # Install dependencies and define the NAT
    server_s2.vm.provision :shell, run: "always", path: "scripts/cloud_server.sh"
  end

end
