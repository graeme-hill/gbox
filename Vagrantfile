Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  # Give vm same ssh identity as host
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "$HOME/.ssh/id_rsa"
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "$HOME/.ssh/id_rsa.pub"

  # vim config
  config.vm.provision "file", source: "init.vim", destination: "$HOME/.config/nvim/init.vim"

  # kubectl repo
  config.vm.provision "file", source: "kubernetes.repo", destination: "$HOME/temp/kubernetes.repo"

  #############################################################################
  # STEP 1 - As root user, install some stuff
  #############################################################################
  config.vm.provision "shell", inline: <<-SHELL
    # First update all the stock packages
    #yum makecache -y
    yum update -y

    # kubectl repo
    mv /home/vagrant/temp/kubernetes.repo /etc/yum.repos.d/kubernetes.repo

    # Setup Docker CE stable repository
    yum install -y yum-utils device-mapper-persistent-data lvm2
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # Python3 and Git2 repo
    yum install -y https://centos7.iuscommunity.org/ius-release.rpm

    # Ripgrep's repo
    yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo

    # Bazel's repo
    yum-config-manager --add-repo=ttps://copr.fedorainfracloud.org/coprs/vbatts/bazel/repo/epel-7/vbatts-bazel-epel-7.repo

    # Make sure yum cache is still up to date after adding repos
    #yum makecache -y

    # Install a whole bunch of stuff
    yum install -y git2u-all dos2unix docker-ce docker-ce-cli zsh python36u \
      python36u-pip ruby ripgrep tree docker-compose kubectl bazel

    # Make python3 and pip3 reference python3.6 and pip3.6
    ln -s /usr/bin/python3.6 /usr/bin/python3
    ln -s /usr/bin/pip3.6 /usr/bin/pip3

    # Standard compilers and junk
    yum groupinstall -y "Development Tools"

    # Get pip2
    easy_install-2.7 pip

    # add non-root user to docker group
    sudo gpasswd -a vagrant docker
  SHELL

  #############################################################################
  # STEP 2 - As non-root user, config some stuff
  #############################################################################
  config.vm.provision "shell", privileged: false, inline: <<-SHELL

    # Git config
    git config --global user.name "Graeme Hill"
    git config --global user.email "graemekh@gmail.com"
    git config --globa core.editor nvim

    # oh my zsh (this writes a default .zshrc that we will overwrite later)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Install golang from tarball into user folder
    if [ ! -d "$HOME/go" ] ; then
      mkdir -p $HOME/Downloads
      curl -L -o $HOME/Downloads/go.tar.gz https://dl.google.com/go/go1.12.4.linux-amd64.tar.gz
      tar -xzf $HOME/Downloads/go.tar.gz -C $HOME
      rm $HOME/Downloads/go.tar.gz
    fi

    # Neovim
    if [ ! -d "$HOME/nvim" ] ; then
      mkdir -p $HOME/Downloads
      curl -L -o ~/Downloads/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.3.4/nvim-linux64.tar.gz
      tar -xzf $HOME/Downloads/nvim.tar.gz -C $HOME
      mv $HOME/nvim-linux64 $HOME/nvim
      rm $HOME/Downloads/nvim.tar.gz
    fi

    # Make sure config files have correct line endings
    dos2unix $HOME/.zshrc
    dos2unix $HOME/.config/nvim/init.vim

    # Allow neovim python plugins
    pip3 install --user neovim
    pip2 install --user neovim

    # Allow neovim ruby plugins
    gem install neovim

    # Install nvm and get a node
    curl https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
    source $HOME/.nvm/nvm.sh
    nvm install node

    # Typescript and co + neovim plugin support
    npm install -g typescript prettier neovim

    # golang things
    export GOPATH=$HOME/gocode
    $HOME/go/bin/go get -u github.com/kardianos/govendor
    $HOME/go/bin/go get -u github.com/golang/protobuf/protoc-gen-go

    # Protobuf compiler
    if [ ! -d "$HOME/protobuf" ] ; then
      curl -L -o ~/Downloads/protobuf.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/protoc-3.7.1-linux-x86_64.zip
      mkdir $HOME/protobuf
      unzip ~/Downloads/protobuf.zip -d $HOME/protobuf
    fi

    # Install vim plugins so they are there on first run
    # $HOME/nvim/bin/nvim +'PlugInstall --sync' +UpdateRemotePlugins +qa
  SHELL

  #############################################################################
  # STEP 3 - As root user, change default shell for vagrant user
  #############################################################################
  config.vm.provision "shell", inline: <<-SHELL
    chsh -s "$(command -v zsh)" vagrant
  SHELL

  # Set zsh config
  config.vm.provision "file", source: ".zshrc", destination: "$HOME/.zshrc"
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    dos2unix $HOME/.zshrc
  SHELL

end
