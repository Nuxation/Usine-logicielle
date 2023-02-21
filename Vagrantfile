# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
$script_inject_pk =<<-'SCRIPT'
cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
cat /vagrant/id_rsa.pub > /home/vagrant/.ssh/id_rsa.pub
cat /vagrant/id_rsa > /home/vagrant/.ssh/id_rsa
SCRIPT

Vagrant.configure(2) do |config|

  config.vm.provision "shell", inline: $script_inject_pk

  config.vm.define "Jenkins" do |jenkins|
    jenkins.vm.box = "ubuntu/focal64"
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.provision "docker"
    jenkins.vm.network "private_network", ip: "192.168.33.11"
    jenkins.vm.provider "virtualbox" do |vb|
      vb.name = "Jenkins"
      vb.memory = 4096
      vb.cpus = 2
    end
  end

  config.vm.define "Prometheus" do |server|
    server.vm.box = "ubuntu/focal64"
    server.vm.hostname = "prometheus"
    server.vm.network "private_network", ip: "192.168.33.12"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "Prometheus"
      vb.memory = 2048
      vb.cpus = 2
    end
  end

  config.vm.define "Stagging" do |dev|
      dev.vm.box = "ubuntu/focal64"
      dev.vm.hostname = "stagging"
      dev.vm.network "private_network", ip: "192.168.45.11"
      dev.vm.provision "docker"
      dev.vm.provider "virtualbox" do |vb|
        vb.name = "Stagging"
        vb.memory = 1024
        vb.cpus = 1
      end
    end

  config.vm.define "Production" do |dev|
    dev.vm.box = "ubuntu/focal64"
    dev.vm.hostname = "production"
    dev.vm.network "private_network", ip: "192.168.45.10"
    dev.vm.provision "docker"
    dev.vm.provider "virtualbox" do |vb|
      vb.name = "Production"
      vb.memory = 1024
      vb.cpus = 1
    end
  end

  N = 3
  (1..N).each do |i|
    config.vm.define "Dev#{i}" do |dev|
      dev.vm.box = "ubuntu/focal64"
      dev.vm.hostname = "dev#{i}"
      dev.vm.network "private_network", ip: "192.168.5.#{10+i}"
      dev.vm.provision "docker"
      dev.vm.provider "virtualbox" do |vb|
        vb.name = "Dev#{i}"
        vb.memory = 1024
        vb.cpus = 1
      end
      dev.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/dev.yml"
      end
    end
  end
end
