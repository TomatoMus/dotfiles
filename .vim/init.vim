"---------------------------------------------------------------------------
" Yasu's .vimrc
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" Initialize:
"
if &compatible
  set nocompatible
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
let g:rc_dir = expand('~/.vim/rc')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  " 設定終了
  call dein#end()
  call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" シンタックス
syntax on

" Rictyフォントpowerline版
set guifont=Ricty\ for\ Powerline\ 12
" 文字コード
set encoding=utf-8
scriptencoding utf-8
"---------------------------------------------------------------------------
" Encoding:
"

"---------------------------------------------------------------------------
" Search:
"

"---------------------------------------------------------------------------
" Edit:
"

"---------------------------------------------------------------------------
" View:
"

"---------------------------------------------------------------------------
" FileType:
"

"---------------------------------------------------------------------------
" Mappings:
"

" ノーマルモードへの移行を＜Ctrl+j＞で行う
inoremap <C-j> <esc>
vnoremap <C-j> <esc>

" 選択したワードをアスタリスクで検索"
vnoremap * "zy:let @/ = @z<CR>n

" 矢印キーを禁止する
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" 括弧の補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

"---------------------------------------------------------------------------
" Commands:
"

"---------------------------------------------------------------------------
" Platform:
"

" 256色
set t_Co=256

" カラースキーマ
colorscheme atom-dark-256

" 行番号表示
set number

" 選択箇所をハイライト"
set hlsearch

"不可視文字の文字の可視化
set list
set listchars=tab:»-,trail:-,eol:¬,extends:»,precedes:«,nbsp:%

" shiftwidth を設定することが可能に
set smarttab
" TABキーを押した際にスペースを入れる
set expandtab
" TABにいくつの空白を設定するか
set tabstop=4
" 自動インデントの際に用いられる各ステップの幅"
set shiftwidth=4

"ステータスラインを常時表示
set laststatus=2

"---------------------------------------------------------------------------
" Plugin:
"
" NERDTree
" ディレクトリ表示記号
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '❐'
let g:NERDTreeDirArrowCollapsible = '▿'
" 起動時にブックマークを表示
let g:NERDTreeShowBookmarks=1
" NERDTreeを起動時に表示
let g:nerdtree_tabs_open_on_gui_startup=1
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeWinSize=24
" 起動時にディレクトリならNERDTree、ファイルならファイルにフォーカスをあてる
let g:nerdtree_tabs_smart_startup_focus=1
" 新規タブを開いた時にもNERDTreeを表示する
let g:nerdtree_tabs_open_on_new_tab=1
" <C-e>でNERDTreeをオンオフ
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>

" indentLine
" 文字を変更
let g:indentLine_char = '⁚'
" 色の変更
let g:indentLine_color_term = 239

" vim-trailing-whitespace
" 保存時に行末の空白を削除
autocmd BufWritePre * :FixWhitespace

"---------------------------------------------------------------------------
" Others:
"

