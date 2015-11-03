set nocompatible

" --------
" settings
" --------
colorscheme desert
syntax enable
set ambiwidth=double
set background=dark
set clipboard=unnamed
set completeopt=menuone
set directory=$HOME/vimswap
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16,utf-16le
set fileformat=unix
set fileformats=unix,dos,mac
set fileformats=unix,dos,mac
set formatoptions=q
set hidden
set hlsearch
set ic
set laststatus=2
set list
set listchars=tab:>-,trail:_,extends:<,precedes:>
set nobackup
set noexpandtab
set nowrapscan
set number
set shiftwidth=4
set showcmd
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set swapfile
set tabstop=4
set ttyfast
set vb t_vb=
au BufNewFile,BufRead * setl fo=cq
au BufNewFile,BufRead *.js setl sw=2 sts=2 ts=2 et
au BufNewFile,BufRead *.vimrc setl sw=2 sts=2 ts=2 et
au BufNewFile,BufRead *.bashrc setl sw=2 sts=2 ts=2 et
au BufNewFile,BufRead *.html set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.js   set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.php  set noexpandtab tabstop=4 shiftwidth=4


" --------
" mappings
" --------
let mapleader = ','
nnoremap <silent> <Leader>vrc :<C-u>edit $MYVIMRC<CR>
nnoremap <Leader>v :<C-u>vsp<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap <BS> gg
nnoremap <C-a> <Home>
nnoremap <C-e> <End>
nnoremap <C-b> <Left>
nnoremap <C-f> <Right>
nnoremap sn :<C-u>bn<CR>
nnoremap sp :<C-u>bp<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap j gj
nnoremap k gk
vnoremap u <Nop>
vnoremap U <Nop>
vnoremap gu <Nop>
vnoremap gU <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap <CR> o<Esc>
