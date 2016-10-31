" Vim basic setting {{{

" Use dark background and enable syntax highlight
set nocompatible
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

set showcmd		  " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase	" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		  " Hide buffers when they are abandoned
set number 
set formatoptions-=cro " Disable continue comment

" Don't use .swp files, git commit a lot and log your changes
set nobackup
set noswapfile

"Hightlight search
set hlsearch

" folding feature setting {
set foldmethod=marker
set foldlevel=0
set modelines=1
" }

" Default indetation {{{
" size of a hard tabstop
set autoindent
set tabstop=2
" Always uses spaces instead of tab characters
set expandtab
" size of an indent " 
set shiftwidth=2
"}}} 
"
"
" Indetation setting according filetype {{{
autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
"}}}

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" }}}

" Vundle plugin management  {{{
function s:StartVundle()
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  " alternatively, pass a path where Vundle should install plugins
  "call vundle#begin('~/some/path/here')

  " let Vundle manage Vundle, required and keep Plugin commands between vundle#begin/end.

  Plugin 'gmarik/Vundle.vim'
  Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
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

  Plugin 'MarcWeber/vim-addon-mw-utils'
  Plugin 'tomtom/tlib_vim'
  Plugin 'garbas/vim-snipmate'
  Plugin 'ecomba/vim-ruby-refactoring'

  " snippets
  Plugin 'honza/vim-snippets'

  " Fast navigate file tool
  Plugin 'kien/ctrlp.vim'

  "auto saves file, quite useful when I choose not to use swap files {
  Plugin 'vim-scripts/vim-auto-save'
  " }
  Plugin 'altercation/vim-colors-solarized'

  "Vim substitute preview tool
  Plugin 'osyo-manga/vim-over'

  "Ack 
  Plugin 'mileszs/ack.vim'

  "easymotion
  Plugin 'easymotion/vim-easymotion'
  " Autoclose
  Plugin 'jiangmiao/auto-pairs'

  Plugin 'Chiel92/vim-autoformat'

  " All of your Plugins must be added before the following line
  call vundle#end()            " required
endfunction

" }}}

" Vundle automatical installation {{{
let s:path = $HOME . '/.vim/bundle/Vundle.vim'
let vundle_repo = 'https://github.com/VundleVim/Vundle.vim.git'
execute 'set runtimepath+=' . s:path
runtime autoload/vundle.vim
if ! exists('*vundle#rc') 
  if executable('git')  
    if confirm('Would you want to install vundle?', "&Yes\n&No", 2, 'Qusetion') == 1 && mkdir(s:path, 'p')
      echo 'Cloning vundle...'
      execute '! git clone ' . vundle_repo . ' ' . s:path
      if v:shell_error
        echomsg 'Cannot clone ' . vundle_repo . s:path . ' may be not empty'
      else
        echo "Hit Enter to installing Plugins..."
        call s:StartVundle()
        autocmd VimEnter * PluginInstall
      endif
    else
      echomsg "You have cancel."
    endif
  else
    echomsg "You should install git and continue."
  endif
endif
" }}}

" File level setting {{{
filetype plugin indent on    " required
"open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" File type icon
set guifont=Literation\ Mono\ Powerline\ Plus\ Nerd\ File\ Types:h11
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'
"}}}

"Mapping Key {{{
"hot keys for ctags
noremap ] <C-]>
noremap [ <C-t>
map t ^
nnoremap 4 $
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
map ema :Email
map eb :Ejob
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
nnoremap <leader>t :NERDTreeToggle<CR>
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1
imap ,, <esc>a<Plug>snipMateNextOrTrigger
smap ,, <Plug>snipMateNextOrTrigger
nnoremap 5 %
nnoremap 1 za
nnoremap , zO
nnoremap ,, zC
" }}}

" Set vim as crontab editor {{{
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif
"}}}
