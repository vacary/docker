# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile for playing around with the FEniCS Docker experience for Linux
# users. Makes a second user vagrant2 with password vagrant for playing with
# the UID/GID switching.

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
   config.vm.provision "shell", inline: <<-SHELL
     curl -sSL https://get.docker.com/ | sh
     useradd -m -s /bin/bash -G sudo,docker vagrant2
     echo "vagrant2:vagrant" | chpasswd
     sudo usermod -aG docker vagrant
   SHELL
end
