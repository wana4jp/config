"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=dotfiles/.vim/plugins/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('dotfiles/.vim/plugins'))

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/unite-outline')
call dein#add('altercation/vim-colors-solarized')
call dein#add('kien/ctrlp.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('tomasr/molokai')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

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

if has("gui_running")
  source ~/.gvimrc
  autocmd GUIEnter * set visualbell t_vb=
endif


" --------
" settings
" --------
colorscheme molokai
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
set noignorecase
set noexpandtab
set backupskip=/tmp/*,/private/tmp/*
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
au FileType php :set dictionary=~/.vim/dict/php.dict

" ctags設定
" 拡張子で読み込みタグ変更
au BufNewFile,BufRead *.php set tags+=$HOME/php.tags
" Tagファイルの生成コマンド (:TagsGenerate で実行する)
au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

au BufNewFile,BufRead *.html set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.js   set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rb   set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.erb  set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.json set expandtab tabstop=2 shiftwidth=2
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
command! EditVimrc  :e ~/.vimrc
" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
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
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" -----------------
" plugin : Unite
" -----------------

let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

nnoremap <silent> <Leader>ug :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap <silent> <Leader>uo :<C-u>Unite outline <CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" -----------------
" plugin : nerdtree
" -----------------
let g:NERDChristmasTree  = 1
let g:NERDTreeShowHidden = 1

nnoremap <silent> <Leader>f :<C-u>NERDTreeToggle<CR>


" ------------------
" plugin : syntastic
" ------------------
let g:syntastic_mode_map = {
  \'mode': 'passive',
  \'active_filetypes': ['php'],
  \'passive_filetypes': [],
  \}
let g:syntastic_php_checkers = ['php']


" --------------
" plugin : ctrlp
" --------------
let g:ctrlp_use_caching = 0
" use `The Silver Searcher`
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
