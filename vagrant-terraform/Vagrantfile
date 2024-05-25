# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box      = "ubuntu/bionic64"
  config.vm.hostname = 'workstation'
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook       = "playbook/setup.yml"
    ansible.version        = "latest"
    ansible.verbose        = false
    ansible.install        = true
    ansible.limit          = "workstation"
    ansible.inventory_path = "playbook/hosts"
  end
end
