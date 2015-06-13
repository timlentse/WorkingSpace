" Vundle automatical installation {{{
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle for current user"
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif
" }}}

" Vim setting {{{
" Use dark background and enable syntax highlight
syntax enable
set background=dark

" Highlight match case
set showmatch

"command autocomplete suggestions
set wildmenu
set wildmode=longest:full,full

"scrolling {
set scrolloff=5
set backspace=indent,eol,start
" }

" Vim setting {
set showcmd		  " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase	" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		  " Hide buffers when they are abandoned
"set mouse=a		  " Enable mouse usage (all modes)

" Indention setting {
" size of a hard tabstop
set tabstop=2

" Always uses spaces instead of tab characters
set expandtab

" size of an  indent " 
set shiftwidth=2

"auto indention
set autoindent

" disable continue comment
set formatoptions-=cro
" }

" Don't use .swp files, git commit a lot and log your changes
set nobackup
set noswapfile

"auto save
set autowrite

"folding feature setting {
set foldmethod=marker
set foldlevel=0
set modelines=1
" }

" }
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" }}}

" Vundle plugin management  {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required and keep Plugin commands between vundle#begin/end.

Plugin 'gmarik/Vundle.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'davidhalter/jedi-vim'
Plugin 'paradigm/vim-multicursor'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'ryanoasis/vim-webdevicons'
Plugin 'ervandew/supertab'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-endwise'
Plugin 'm2ym/rsense'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rails'
Plugin 'tomtom/tcomment_vim'

" Fast navigate file tool
Plugin 'kien/ctrlp.vim'

"auto saves file, quite useful when I choose not to use swap files {
Plugin 'vim-scripts/vim-auto-save'
" }
Plugin 'altercation/vim-colors-solarized'

"Vim substitute preview tool
Plugin 'osyo-manga/vim-over'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" }}}

" File level setting {{{
filetype plugin indent on    " required
"open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" File type icon
set guifont=Literation\ Mono\ Powerline\ Plus\ Nerd\ File\ Types:h11
"}}}

"Mapping Key {{{
map t ^
nnoremap ba $
nnoremap rf gg^vG^=
map ; :
map m :set number<CR>
map cm :set nonumber<CR>
nnoremap fp :OverCommandLine<CR>%s/
map qi :q!
map <C-a> ggVG
map <C-c> y:call system("pbcopy", getreg("\""))<CR>
map vp :vsplit
" for rails-vim {
map em :Emodel
map ev :Eview
map ec :Econtroller
map ej :Ejavascript
map es :Estylesheet
map ei :Eimages
"}
map cap ca(
map caq ca"
map cip ci(
map ciq ci"
map ct c^
map cb c$
nnoremap dt d^
nnoremap db d$
nnoremap <Space> <C-d> 
nnoremap fs :CtrlPMRU<CR>
" }}}
