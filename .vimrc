"  __      ____ _ _ __   __ _ ___| |__ (_)
"  \ \ /\ / / _` | '_ \ / _` / __| '_ \| |
"   \ V  V / (_| | | | | (_| \__ \ | | | |
"    \_/\_/ \__,_|_| |_|\__,_|___/_| |_|_|

set nocompatible

" -------
" plugins
" -------
filetype plugin indent off
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
filetype plugin indent on

NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
NeoBundle 'bling/vim-airline'
NeoBundle 'git://github.com/Shougo/unite.vim'
NeoBundle 'git://github.com/guileen/simple-javascript-indenter'
NeoBundle 'git://github.com/kien/ctrlp.vim'
NeoBundle 'git://github.com/mattn/emmet-vim.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'pyte'
NeoBundle 'phd'
NeoBundle 'supasorn/vim-easymotion'


" -----------
" environment
" -----------
let OSTYPE = system('uname')
if OSTYPE == "Darwin\n"
  vnoremap <silent> sy :!pbcopy; pbpaste<CR>
  noremap  <silent> sp <esc>o<esc>v:!pbpaste<CR>
elseif OSTYPE == "Linux\n"
  set ttytype=builtin_linux
  set term=builtin_linux
  set t_Co=256
endif


" --------
" settings
" --------
colorscheme phd
syntax on
set ambiwidth=double
set background=dark
set clipboard=unnamed
set completeopt=menuone
set directory=$HOME/vswap
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
set noexpandtab
set nowrapscan
set number
set shiftwidth=4
set showcmd
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set tabstop=4
set ttyfast
set vb t_vb=
au BufNewFile,BufRead * setl fo=cq
au BufNewFile,BufRead *.js setl sw=2 sts=2 ts=2 et
au BufNewFile,BufRead *.vimrc setl sw=2 sts=2 ts=2 et
au BufNewFile,BufRead *.bashrc setl sw=2 sts=2 ts=2 et


" --------
" mappings
" --------
let g:mapleader = ','
nnoremap <silent> <LEADER>id :<C-u>edit ~/Dropbox/text/idea.mkd<CR>
nnoremap <silent> <LEADER>td   :<C-u>edit ~/Dropbox/text/todo.mkd<CR>
nnoremap <silent> <LEADER>bsh :<C-u>edit ~/.bashrc<CR>
nnoremap <silent> <LEADER>vrc :<C-u>edit $MYVIMRC<CR>
nnoremap <LEADER>v :<C-u>vsp<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sp :<C-u>bp<CR>
nnoremap sn :<C-u>bn<CR>
nnoremap <C-y> :<C-u>MyToggleSimpleDisplay<CR>
function! s:toggleSimpleDisplay()
  set number!
  set list!
endfunction
command! MyToggleSimpleDisplay call s:toggleSimpleDisplay()
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
command! EditVimrc :e ~/.vimrc
command! EditGvimrc :e ~/_gvimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END
function! s:closeBuffer()
  let l:cur_buf = bufnr('%')
  if buflisted(bufnr('#'))
    buf #
  else
    bn
  endif
  if bufnr('%') == l:cur_buf
    new
  endif
  exe 'bd ' . l:cur_buf
  if 0 != bufloaded(l:cur_buf)
    exe 'buf ' . l:cur_buf
  endif
endfunction
command! MyCloseBuffer call s:closeBuffer()
nnoremap sd :<C-u>MyCloseBuffer<CR>

" for plugins
nnoremap <silent> <LEADER>f :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <LEADER>uo :<C-u>Unite<Space>outline<CR>


" -----------------
" plugin : nerdtree
" -----------------
let g:NERDChristmasTree  = 1
let g:NERDTreeShowHidden = 1


" ------------------
" plugin : syntastic
" ------------------
let g:syntastic_mode_map = {
  \'mode': 'passive',
  \'active_filetypes': ['php'],
  \'passive_filetypes': [],
  \}


" --------------
" plugin : ctrlp
" --------------
let g:ctrlp_working_path_mode = 0


" ----------------------
" plugin : neocomplcache
" ----------------------
let g:neocomplcache_plugin_disable = {
  \ 'syntax_complete' : 1,
  \ }
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 20
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ }


" ----------------------
" plugin : vim-easymotion
" ----------------------
let g:EasyMotion_leader_key = ';'
let g:EasyMotion_keys='hsdgyuiopqwertnmzxcvb;:f'
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
let g:EasyMotion_special_select_line = 0
let g:EasyMotion_special_select_phrase = 0


" -------------
" local
" -------------
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
