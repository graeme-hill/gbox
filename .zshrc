export ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="graeme"

plugins=(
  git
)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

source /usr/share/nvm/init-nvm.sh

PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"