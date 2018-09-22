# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.provision "shell", inline: <<-SHELL

    apt-get update

    apt-get install -y \
      vim \ 
      git \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common \
      yarn

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

    apt-get update
    apt-get install -y docker-ce docker-compose

    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    source ~/.bashrc
    nvm install node

  SHELL
end
