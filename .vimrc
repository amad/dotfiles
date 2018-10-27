version 7.0

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')

" leader = \
Plug 'scrooloose/nerdtree'
" Plug 'matchit.zip'
Plug 'tpope/vim-fugitive'
Plug 'c9s/perlomni.vim'
"Plug 'kien/ctrlp.vim'
"  map <Leader>t :CtrlPBuffer<CR>
"  let g:ctrlp_working_path_mode = 0 " don’t manage working directory.
"  let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v\c\.(git|svn)$|cgi/t/sandbox|cover_db',
"  \ 'file': '\v\c\.(swf|bak|png|gif|mov|ico|jpg|pdf|jrxml)$',
"  \ }
Plug 'Lokaltog/vim-powerline'
  let g:Powerline_symbols = 'fancy'
Plug 'Lokaltog/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_sign_column_always = 1
  highlight clear SignColumn
  Plug 'vim-ruby/vim-ruby'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'joonty/vdebug'
Plug 'lumiliet/vim-twig'
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'nishigori/vim-php-dictionary'
Plug 'phpstan/vim-phpstan'
" Plug 'Valloric/YouCompleteMe'
" Plug 'junegunn/fzf'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-plug'

" FZF / Ctrlp for file navigation
if executable('fzf')
  " OSX vs Linux loading (depending on where fzf is)
  let s:uname = system("echo -n \"$(uname)\"")
  if !v:shell_error && s:uname == "Darwin"
    Plug '/usr/local/opt/fzf'
  else
    Plug 'junegunn/fzf', {'dir': '~/.local/src/fzf', 'do': './install --all' }
  endif
  Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
endif

call plug#end()

let mapleader = ' '
let maplocalleader = ' '

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start
set cindent " set smartindent
set cmdheight=2
set cursorcolumn
set cursorline
set errorformat=\"../../%f\"\\,%*[^0-9]%l:\ %m
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-
set mouse=c
set nowrap
set number
set ruler
set scrolloff=5
set showcmd
set showmatch
set smarttab
"set statusline=%F%m%r%h%w\ [%{&ff}]\ %y\ [CHR=%b/0x%B]\ [POS=%04l,%03c(%03v)]\ [%p%%]\ [LEN=%L]\ %{fugitive#statusline()}
set t_Co=256
set tags=tags;/
set virtualedit=block
set wrap
set shell=/bin/bash
syntax on


colorscheme mustang
highlight   cursorcolumn  term=none    cterm=none gui=none   ctermbg=232
highlight   cursorline    term=none    gui=none   cterm=none ctermbg=232
highlight   FoldColumn                            ctermbg=8  ctermfg=14
highlight   Folded                                ctermbg=8  ctermfg=14
highlight   Search        term=reverse cterm=bold ctermbg=11 ctermfg=0
highlight   Visual        term=NONE    cterm=bold ctermbg=10 ctermfg=8

"" makes Omni Completion less pinky :P
highlight   Pmenu                                 ctermbg=2  ctermfg=0
highlight   PmenuSel                              ctermbg=7  ctermfg=0
highlight   PmenuSbar                             ctermbg=0  ctermfg=7
highlight   PmenuThumb                            ctermbg=7  ctermfg=0

" :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

nnoremap <C-L> :noh<CR><C-L>
inoremap jj <Esc>
nnoremap <Leader>r :source ~/.vimrc<CR>
nnoremap <Leader><Leader>r :e ~/.vimrc<CR>

map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gm :Gcommit --amend<CR>
map <Leader>gll :Git log<CR>
map <Leader>glp :Git log -p<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gdd :Git diff<CR>
map <Leader>gdm :Git diff %<CR>
map <Leader>gdf :Gdiff<CR>
map <Leader>gg :Git

map <Leader>] :wa<bar><UP><CR>

nmap <F1> <Esc>
imap <F1> <Esc>

autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
autocmd FileType php noremap <C-L> :!/usr/bin/env php -l %<CR>
autocmd FileType phtml noremap <C-L> :!/usr/bin/env php -l %<CR>


"colorscheme srcery
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

:nnoremap <F8> :!!<CR>
:map - :w \| :!!<CR>

set clipboard=unnamed
:nnoremap Q <Nop>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

map <C-n> :NERDTreeToggle<CR>
autocmd BufWritePre *.* :%s/\s\+$//e
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Ripgrep for file indexing, sort of faster, but not really, but also why not use ripgrep for everything
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages "" .'
endif

" Use FZF for files and tags if available, otherwise fall back onto CtrlP
" <leader>j will search for tag using word under cursor
let g:fzf_command_prefix = 'Fzf'
if executable('fzf')
  nnoremap <leader>t :FzfFiles<cr>
  nnoremap <leader>u :FzfTags<cr>
  nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'))<cr>
else
  nnoremap <leader>t :CtrlP<Space><cr>
endif
