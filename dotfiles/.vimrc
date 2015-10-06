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
NeoBundle 'git://github.com/Shougo/vimproc.git', {
\	'build': {
\		'mac':  'make -f make_mac.mak',
\		'unix': 'make -f make_unix.mak',
\	},
\}
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'git://github.com/Shougo/unite.vim'
NeoBundle 'git://github.com/kien/ctrlp.vim'
NeoBundle 'git://github.com/mattn/emmet-vim.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'szw/vim-tags'
NeoBundle 'tomasr/molokai'
NeoBundle 'git://github.com/terryma/vim-expand-region.git'
NeoBundle 'vim-scripts/gitignore'
NeoBundle 'fatih/vim-go'

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
au FileType php :set dictionary=~/.vim/dict/php.dict

" ctags設定
" 拡張子で読み込みタグ変更
au BufNewFile,BufRead *.php set tags+=$HOME/php.tags
" Tagファイルの生成コマンド (:TagsGenerate で実行する)
au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" html / js のインデントはスペース2
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

" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> <Leader>ug :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" バッファ一覧
nnoremap <silent> <Leader>ub :<C-u>Unite buffer -buffer-name=file<CR>

" カーソル位置の単語をgrep検索
" nnoremap <silent> <Leader>cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
" nnoremap <silent> <Leader>r  :<C-u>UniteResume search-buffer<CR>

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
"let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 0
" CtrlPでのgit または The Silver Searcher を使用する
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif



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


" --------------------------
" plugin : vim-expand-region
" --------------------------
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

