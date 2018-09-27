Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provision "file", source: ".zshrc", destination: "$HOME/.zshrc"
  config.vm.provision "file", source: "init.vim", destination: "$HOME/.config/nvim/init.vim"

  #############################################################################
  # STEP 1 - As root user, install the pre-reqs to use yay
  #############################################################################
  config.vm.provision "shell", inline: <<-SHELL
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
      docker nvm-git neovim vim-plug-git zsh oh-my-zsh-git yarn tree
    
    # Get a node
    source /usr/share/nvm/init-nvm.sh
    nvm install node

    # Typescript
    npm install -g typescript
  SHELL

  #############################################################################
  # STEP 3 - As root user, change default shell
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