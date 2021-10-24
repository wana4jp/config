" Basic Settings

" Plugin Manager
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/plugins/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/plugins'))
  let g:dein_dir = expand('~/.vim')
  let s:toml = g:dein_dir . '/dein.toml'
  let s:lazy_toml = g:dein_dir . '/dein_lazy.toml'
  call dein#begin(expand('~/.vim/plugins'), [$MYVIMRC, s:toml, s:lazy_toml])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
if dein#check_install()
  call dein#install()
endif

" let OSTYPE = system('uname')

colorscheme vim-monokai-tasty
set background=dark
set number
set nowrap
set laststatus=2   " 2 : always
set ambiwidth=double
set showtabline=2
set listchars=tab:>-,trail:_,extends:<,precedes:>
set list
syntax enable

" Edit
set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16,utf-16le
set noexpandtab
set tabstop=4
set autoread
autocmd FileType * setlocal textwidth=0

" Search and Replace
set hlsearch
set noignorecase
set incsearch

" Others
set nobackup
set clipboard=unnamed
set directory=$HOME/vimswap
set swapfile
set ttyfast
set vb t_vb=
au BufNewFile,BufRead *.es6 setfiletype javascript
au BufNewFile,BufRead *.erb  set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.html set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.js   set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.json set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.php  set noexpandtab tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.blade.php set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rb   set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.sh   set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.svg  set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.txt  set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.yml  set expandtab tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.md   set expandtab tabstop=2 shiftwidth=2

" Key mappings
let mapleader = ','
map ; :
nnoremap <silent> <Leader>vrc :<C-u>edit $MYVIMRC<CR>

nnoremap <Leader>v :<C-u>vsp<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
vnoremap <leader>p "_dP
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap nmap <silent> * "syiw<Esc>: let @/ = @s<CR> " *で検索時に、次の検索候補へのジャンプをしない
nnoremap sn :<C-u>bn<CR>
nnoremap sp :<C-u>bp<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap j gj
nnoremap k gk
vnoremap u <nop>
vnoremap U <Nop>
nnoremap K <Nop>
nnoremap Q <Nop>
nnoremap ZQ <Nop>
nnoremap ZZ <Nop>
vnoremap gU <Nop>
vnoremap gu <Nop>
map ; :
nnoremap <CR> o<Esc>
nnoremap <SPACE> i<SPACE><Esc>
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>
command! EditVimrc  :e ~/.vimrc " auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
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

" Plugin Settings

" Unite
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
nnoremap <silent> <Leader>ug :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap <silent> <Leader>uo :<C-u>Unite outline <CR>
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column -U'
  let g:unite_source_grep_recursive_opt = ''
endif

" vim-quickrun
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}
nnoremap <silent> <Leader>q :<C-u>QuickRun <CR>

" vim-markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_disabled = 1

" nerdtree
let g:NERDChristmasTree  = 1
let g:NERDTreeShowHidden = 1
nnoremap <silent> <Leader>f :<C-u>NERDTreeToggle<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_php_checkers = ['php']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ctrlp
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" -U'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
        \ }
endif

" vim-auto-save
autocmd FileType * call s:autoSaveSetting()
function! s:autoSaveSetting()
  let l:file_type = &ft
  if 'markdown' == l:file_type
    let g:auto_save = 1
  else
    let g:auto_save = 0
  endif
endfunction

" javascript-libraries-syntax
augroup MyVimrc
  autocmd!
augroup END
function! EnableJavascript()
  " Setup used libraries
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction
autocmd MyVimrc FileType javascript,javascript.jsx call EnableJavascript()
