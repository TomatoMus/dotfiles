"** システム設定 **
"選択したワードをアスタリスクで検索"
vnoremap * "zy:let @/ = @z<CR>n
"ノーマルモードへの移行を＜Ctrl+j＞で行う
imap <C-j> <esc>
"swpファイルをつくらない
set noswapfile
"ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect
"矢印キーを禁止する
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
"delete が効かないときの設定
set backspace=indent,eol,start


"** 文字設定 **
"Rictyフォントpowerline版
set guifont=Ricty\ for\ Powerline\ 12
" 文字コード
scriptencoding utf-8
set encoding=utf-8
" TABキーを押した際にタブ文字の代わりにスペースを入れる
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
" indentLine の文字を変更
let g:indentLine_char = '|'
" 括弧系閉じ補完
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
" 挿入モードを出る時，現在の IME の状態を保存し，IME をオフにする．（Gvimのみ）
set imdisable

"** 表示設定 **
"行番号表示
set number
"選択箇所をハイライト"
set hlsearch
"隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1 
"<C-e>でNERDTreeをオンオフ。いつでもどこでも。
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
"エディタウィンドウの末尾から2行目にステータスラインを常時表示
set laststatus=2
"screen を 256色対応で
set t_Co=256
"不可視文字の文字の可視化
set list
set listchars=tab:»-,trail:-,eol:¬,extends:»,precedes:«,nbsp:%
"シンタックス
syntax on

"** プリンタ設定 **
"行番号の表示、余白
set printoptions=number:y,left:5pc
"プリント時のフォント
set printfont=Ricty\ for\ Powerline\ 12



"パワーラインのスキーマ
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component': {
        \   'readonly': '%{&readonly?"x":""}',
        \ },
        \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
        \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }
"パワーラインのvimfilerのパス表示
function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"** カラースキーマ設定 (スキーマはダウンロードしてくる)**
""let g:molokai_original=1
colorscheme lucius 
set background=dark




"**プログラミング言語別設定**
"===phpの基本設定===
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1

" dbがmysqlの場合
let g:sql_type_default='mysql'

"=====rubyの基本設定=====
"Rsense
let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense-0.3'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 20
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
if !exists('g:neocomplcache_delimiter_patterns')
    let g:neocomplcache_delimiter_patterns = {}
endif
let g:rsenseUseOmniFunc = 1

"neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"rubocop
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'python'] }
""let g:syntastic_ruby_checkers = ['rubocop']


"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'


" --------ここから追加のプラグイン---------

" NERDTreeを設定
NeoBundle 'scrooloose/nerdtree'

" 自動の綴じカッコ
"NeoBundle 'Townk/vim-autoclose'

" powerlineの派生lightline
NeoBundle 'itchyny/lightline.vim'

" vimファイラ
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'

" html/CSS入力補助プラグイン
NeoBundle 'mattn/emmet-vim'

" インデントをスペースで可視化
NeoBundle 'Yggdroot/indentLine'

" テキストオブジェクトを拡張するプラグイン
"NeoBundle 'taichouchou2/surround.vim'

" スニペット補完
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" コード補完
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'


" 各種スニペット
NeoBundle 'Shougo/neosnippet-snippets'

" シンタックスチェック
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'


" ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'


" Plugin key-mappings.  " <C-k>でsnippetの展開
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

"自動的テンプレートの作成
NeoBundle 'aperezdc/vim-template'

"メソッド定義元へジャンプ
NeoBundle 'szw/vim-tags'

"python用自動補完プラグイン
NeoBundle 'davidhalter/jedi-vim'

"vim-latexプラグイン
"NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
"NeoBundle 'lervag/vim-latex'
"
"コメントアウトプラグイン
NeoBundle 'tomtom/tcomment_vim'

"set pasteモード自動化
NeoBundle 'ConradIrwin/vim-bracketed-paste'

"カラースキーム
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'
NeoBundle 'raphamorim/lucario'
NeoBundle 'vim-scripts/desertEx'

" カラースキーム一覧表示に Unite.vim を使う
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
" --------ここまで追加のプラグイン---------


call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 追加つすときの確認をするかどうか
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------

