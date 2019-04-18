ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bira"

plugins=(
  git
)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export GOPATH=$HOME/gocode
export PATH=$PATH:$HOME/go/bin:$HOME/gocode/bin:$HOME/nvim/bin:$HOME/.cargo/bin:$HOME/protobuf/bin:"$(ruby -e 'print Gem.user_dir')/bin"