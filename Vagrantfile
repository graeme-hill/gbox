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
    yum update -y

    # kubectl repo
    mv /home/vagrant/temp/kubernetes.repo /etc/yum.repos.d/kubernetes.repo

    # Setup Docker CE stable repository
    yum install -y yum-utils device-mapper-persistent-data lvm2
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # Ripgrep's repo
    yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo

    # Install a whole bunch of stuff
    yum install -y git dos2unix docker-ce docker-ce-cli zsh python36 \
      python36-setuptools python-setuptools ruby ripgrep tree docker-compose \
      kubectl

    # Standard compilers and junk
    yum groupinstall -y "Development Tools"

    # Get pip2 and pip3
    easy_install-3.6 pip
    easy_install-2.7 pip
  SHELL

  #############################################################################
  # STEP 2 - As non-root user, config some stuff
  #############################################################################
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
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

    # Install vim plugins so they are there on first run
    $HOME/nvim/bin/nvim +'PlugInstall --sync' +UpdateRemotePlugins +qa

    # golang things
    export GOPATH=$HOME/gocode
    $HOME/go/bin/go get -u github.com/kardianos/govendor

  SHELL

  #############################################################################
  # STEP 3 - As root user, change default shell for vagrant user
  #############################################################################
  config.vm.provision "shell", inline: <<-SHELL
    chsh -s "$(command -v zsh)" vagrant
  SHELL

  # Set zsh config
  config.vm.provision "file", source: ".zshrc", destination: "$HOME/.zshrc"

end
