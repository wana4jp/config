if has('multi byte ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=


" --------
" settings
" --------
colorscheme pyte
set background=light
set encoding=utf-8
set langmenu=ja_jp.utf-8
set showtabline=2
set imdisable


" --------
" mappings
" --------
nnoremap <silent> <LEADER>gvim :<C-u>edit $MYGVIMRC<CR>
