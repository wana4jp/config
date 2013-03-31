" 初期化 =======================================================================
" vi互換にしない
set nocompatible



" neobundleの設定 ==============================================================
filetype plugin indent off
if has('vim_starting')
	set runtimepath+=~/.vim/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle/'))
endif
filetype plugin indent on

" 設定ファイルを読み込む
set runtimepath+=~/.vim/
runtime! setting.vim

" カラースキーマ
NeoBundle 'git://github.com/tomasr/molokai.git'
"NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'

" ファイラー
NeoBundle 'git://github.com/scrooloose/nerdtree.git'

" ファイルセレクタ
NeoBundle 'git://github.com/kien/ctrlp.vim'

" シンタックスチェック
NeoBundle 'git://github.com/scrooloose/syntastic.git'

" 文字列の複数検索
" NeoBundle 'git://github.com/vim-scripts/MultipleSearch.git'

" APIライブラリ検索
" NeoBundle 'git://github.com/thinca/vim-ref.gif'

" コードの即時実行
NeoBundle 'git://github.com/thinca/vim-quickrun.git'

" DBへの接続
NeoBundle 'git://github.com/vim-scripts/dbext.vim.git'



" ファイル設定 =================================================================
set ambiwidth=double

" 文字エンコード
set encoding=utf-8
" 文字エンコードの認識優先度
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16,utf-16le
" 改行コード
set fileformat=unix
" 改行コードの認識優先度
set fileformats=unix,dos,mac

" 不可視文字の表示
set list
set listchars=tab:>-,trail:_,extends:<,precedes:>

" 表示行単位移動
nnoremap j gj
nnoremap k gk

" タブの表示幅
set tabstop=4

" タブ挿入の幅
set shiftwidth=4

" タブをスペースとしない
set noexpandtab

" ターミナルのカラー化
if has('unix')
	set ttytype=builtin_linux
	set term=builtin_linux
	set t_Co=256
endif

set fileformats=unix,dos,mac

" カラースキーマ
colorscheme molokai
"colorscheme solarized
syntax on

" 行番号を表示する
set number

" 検索を循環させない
set nowrapscan

" エラーの音を消す
set vb t_vb=

" 検索文字をハイライト
set hlsearch

" 大文字小文字を区別しない
set ic

" シフトで多めに移動
noremap J 30j
noremap K 30k
noremap L 10l
noremap H 10h



" キーマッピング ===============================================================
" [,]を<LEADER>にする
let mapleader = ','

" vimrc編集
nnoremap <silent> <LEADER>vim :<C-u>edit $MYVIMRC<CR>

" 行頭行末
noremap <C-a> 0
noremap <C-e> $

" 画面分割
nnoremap <LEADER>v :<C-u>vsp<CR>

" 分割画面間移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" 前のバッファに移動する
nnoremap sp :<C-u>bp<CR>
" 次のバッファに移動する
nnoremap sn :<C-u>bn<CR>

" インサートモード抜ける
inoremap jk <ESC>

" コピーするときには表示切り替えてインデントとか入らないようにする
nnoremap <F11> :<C-u>MyToggleSimpleDisplay<CR>

function! s:toggleSimpleDisplay()
	if &list
		set nonumber
		set nolist
	else
		set number
		set list
	endif
endfunction
command! MyToggleSimpleDisplay call s:toggleSimpleDisplay()



" nerd_tree --------------------------------------------------------------------
" カラー表示する
let g:NERDChristmasTree  = 1
" 隠しファイルを表示する
let g:NERDTreeShowHidden = 1

" ファイラ表示切替
nnoremap <silent> <LEADER>f :<C-u>NERDTreeToggle<CR>



" syntastic --------------------------------------------------------------------
" モード設定
let g:syntastic_mode_map = {
	\'mode': 'passive',
	\'active_filetypes': ['php'],
	\'passive_filetypes': [],
	\}



" MultipleSearch ---------------------------------------------------------------
" 検索
" nnoremap <silent> <LEADER>s yiw:<C-u>Search <C-R>"<CR>
" nnoremap <silent> * yiw:<C-u>Search <C-R>"<CR>

" リセット
" nnoremap <silent> <LEADER>q :<C-u>SearchReset<CR>



" vim-ref ----------------------------------------------------------------------
"php マニュアルインストールメモ
"$ cd ~/.vim/
"$ wget http://jp2.php.net/get/php_manual_en.tar.gz/from/jp.php.net/mirror
"$ tar zxvf php_manual_en.tar.gz
let g:ref_phpmanual_path=$HOME . '/.vim/php-chunked-xhtml'



" ctrlp   ----------------------------------------------------------------------
" 検索開始を現在のディレクトリからにする
let g:ctrlp_working_path_mode = 0



" quick-run  -------------------------------------------------------------------
" 設定情報は.vim/setting.vimに記載する
" SQLファイルの設定
let g:quickrun_config = {}
let g:quickrun_config['sql'] = {
	\ 'command': 'mysql',
	\ 'exec': ['%c %o < %s'],
	\ 'cmdopt': '%{MakeMySQLCommandOptions()}',
	\ }
function! MakeMySQLCommandOptions()
	if !exists("g:mysql_config_host")
		let g:mysql_config_host = input("host> ")
	endif
	if !exists("g:mysql_config_port")
		let g:mysql_config_port = input("port> ")
	endif
	if !exists("g:mysql_config_user")
		let g:mysql_config_user = input("user> ")
	endif
	if !exists("g:mysql_config_pass")
		let g:mysql_config_pass = inputsecret("password> ")
	endif
	if !exists("g:mysql_config_db")
		let g:mysql_config_db = input("database> ")
	endif

	let optlist = []
	if g:mysql_config_user != ''
		call add(optlist, '-u ' . g:mysql_config_user)
	endif
	if g:mysql_config_host != ''
		call add(optlist, '-h ' . g:mysql_config_host)
	endif
	if g:mysql_config_pass != ''
		call add(optlist, '-p' . g:mysql_config_pass)
	endif
	if g:mysql_config_port != ''
		call add(optlist, '-P ' . g:mysql_config_port)
	endif
	if exists("g:mysql_config_otheropts")
		call add(optlist, g:mysql_config_otheropts)
	endif

	call add(optlist, g:mysql_config_db)
	return join(optlist, ' ')
endfunction


" dbext  -------------------------------------------------------------------
" 設定情報は.vim/setting.vimに記載する

" 実行結果は上に、30行出す。
let g:dbext_default_buffer_lines = 30
let g:dbext_default_window_use_bottom = 0
