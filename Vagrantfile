Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provision "file", source: ".zshrc", destination: "$HOME/.zshrc"

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
    git clone https://aur.archlinux.org/yay.git
    pushd yay
    makepkg -si --noconfirm
    popd

    # Update package list and upgrade anything existing out of date packages
    yay -Syu --needed

    # Install a bunch of things
    yay -S --noconfirm --needed \
      docker nvm-git neovim vim-plug-git zsh oh-my-zsh-git
  SHELL

  #############################################################################
  # STEP 3 - As root user, change default shell
  #############################################################################
  config.vm.provision "shell", inline: <<-SHELL
    chsh -s "$(command -v zsh)" vagrant
  SHELL
end