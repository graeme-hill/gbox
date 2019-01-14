cp .zshrc ~/.zshrc
mkdir -p ~/.config
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

sudo rm -r /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy --noconfirm --needed git base-devel

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
  docker docker-compose nvm-git neovim zsh oh-my-zsh-git yarn tree ripgrep python \
  python-pip python2 python2-pip ruby rubygems clang dos2unix

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

# change shell to zsh
sudo chsh -s "$(command -v zsh)" graeme

# allow docker without sudo
sudo usermod -aG docker $USER

mkdir -p ~/temp
cp graeme.zsh-theme ~/temp/graeme.zsh-theme
sudo mv /home/graeme/temp/graeme.zsh-theme /usr/share/oh-my-zsh/themes
