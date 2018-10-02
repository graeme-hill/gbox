" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'zchee/deoplete-clang'
Plug 'bfrg/vim-cpp-modern'
Plug 'jremmen/vim-ripgrep' " :Rg <something>
Plug 'tpope/vim-surround' " :S(
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'jacoborus/tender'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jremmen/vim-ripgrep'
Plug 'hashivim/vim-vagrant'
Plug 'ianks/vim-tsx'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-sleuth'
Plug 'uarun/vim-protobuf'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-obsession'
Plug 'altercation/vim-colors-solarized'
call plug#end()

" auto complete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Visuals
colorscheme iceberg

" Airline stuff
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 1 " https://github.com/bling/vim-airline/wiki/FAQ
let g:airline#extensions#whitespace#enabled = 0 " too obtrusive
let g:airline_theme = "hybrid"
let g:airline#extensions#hunks#enabled = 0 " no room :(
let g:airline_section_y = '' " no room :'(
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 0 " just nevever found it that useful :/

" navigate windows better
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <C-p> :FZF -m<cr>
map <C-q> :NERDTreeToggle<CR>
map <C-t> :terminal<CR>
map <M-h> :vertical resize -1<CR>
map <M-j> :resize -1<CR>
map <M-k> :resize +1<CR>
map <M-l> :vertical resize +1<CR>
map <S-h> :tabp<CR>
map <S-l> :tabn<CR>
map <S-k> :tabe<CR>

set showmatch
set number
set cursorline
set nojoinspaces
set autoread

filetype plugin indent on
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent

set splitbelow
set splitright

set scrolloff=999

set hidden " allow switching from unsaved buffers

" show whitespace
set list
"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" golang specific tab rules
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
