Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  # Give vm same ssh identity as host
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "$HOME/.ssh/id_rsa"
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "$HOME/.ssh/id_rsa.pub"

  # Dotfiles
  config.vm.provision "file", source: ".zshrc", destination: "$HOME/.zshrc"
  config.vm.provision "file", source: "init.vim", destination: "$HOME/.config/nvim/init.vim"

  #############################################################################
  # STEP 1 - As root user, install the pre-reqs to use yay
  #############################################################################
  config.vm.provision "shell", inline: <<-SHELL
    rm -r /etc/pacman.d/gnupg
    pacman-key --init
    pacman-key --populate archlinux
    pacman -Sy --noconfirm archlinux-keyring
    pacman -Syyu --noconfirm
    pacman -Sy --noconfirm --needed git base-devel
  SHELL

  #############################################################################
  # STEP 2 - Install yay and a bunch of stuff
  #############################################################################
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    # Install yay itself
    if [ ! -d "yay" ] ; then
      git clone https://aur.archlinux.org/yay.git yay
      pushd yay
      makepkg -si --noconfirm
      popd
    fi

    # Update package list and upgrade anything existing out of date packages
    yay -Syu --needed

    # Install a bunch of things
    yay -S --noconfirm --needed \
      docker docker-compose nvm-git neovim zsh oh-my-zsh-git yarn tree ripgrep \
      python python-pip python2 python2-pip ruby rubygems clang dos2unix
    
    # Make sure config files have correct line endings
    dos2unix $HOME/.zshrc
    dos2unix $HOME/.config/nvim/init.vim

    # Allow neovim python plugins
    pip3 install --user neovim
    pip2 install --user neovim

    # Allow neovim ruby plugins
    gem install neovim

    # Get a node
    source /usr/share/nvm/init-nvm.sh
    nvm install node

    # Typescript and co + neovim plugin support
    npm install -g typescript prettier neovim

    # Install vim plugins so they are there on first run
    nvim +'PlugInstall --sync' +UpdateRemotePlugins +qa

    # golang things
    go get -u github.com/kardianos/govendor
  SHELL

  #############################################################################
  # STEP 3 - As root user, change default shell for vagrant user
  #############################################################################
  config.vm.provision "shell", inline: <<-SHELL
    chsh -s "$(command -v zsh)" vagrant
  SHELL

  #############################################################################
  # STEP 4 - Custom zsh theme
  #############################################################################
  config.vm.provision "file", source: "graeme.zsh-theme", destination: "$HOME/temp/graeme.zsh-theme"
  config.vm.provision "shell", inline: <<-SHELL
    mv /home/vagrant/temp/graeme.zsh-theme /usr/share/oh-my-zsh/themes
  SHELL
end
