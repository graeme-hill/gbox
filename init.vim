" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'leafgarland/typescript-vim'
Plug 'jremmen/vim-ripgrep' " :Rg <something>
Plug 'tpope/vim-surround' ":S(
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
call plug#end()

colorscheme onedark
AirlineTheme papercolor

" navigate windows better
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent> <C-p> :FZF -m<cr>
map <C-o> :NERDTreeToggle<CR>
map <C-t> :terminal<CR>

set showmatch
set number
set nojoinspaces

filetype plugin indent on
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set splitbelow
set splitright

set scrolloff=999