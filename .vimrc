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

" 選択箇所をハイライト"
set hlsearch

"---------------------------------------------------------------------------
" Edit:
"

" スワップファイルを作成しない
set noswapfile

" アンドゥファイルを作成しない
" set noundofile

" バックアップファイルを作成しない
" set nobackup

" viminfoファイルを作成しない
" set viminfo=

"---------------------------------------------------------------------------
" View:
"

" 256色
set t_Co=256

" 起動時メッセージを表示しない
set shortmess& shortmess+=I

" カラースキーマ
colorscheme atom-dark-256

" 行番号表示
set number

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

" ステータスラインを常時表示
set laststatus=2

" 必要なときだけカーソルラインを表示
hi clear CursorLine
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')
  setlocal cursorline
  hi clear CursorLine
  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      hi CursorLine term=underline cterm=underline guibg=Grey90
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
      hi clear CursorLine
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          hi clear CursorLine
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      hi CursorLine term=underline cterm=underline guibg=Grey90
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" ウィンドウの境界線の設定
set fillchars+=vert:\⎢
hi! VertSplit ctermfg=235 ctermbg=235 term=NONE

" 初期起動時の空行のチルダの設定
hi! NonText ctermfg=234 ctermbg=234 term=NONE

" Wrap Guide(80:warning, 120:danger)
set textwidth=80
set colorcolumn=+1
let &colorcolumn="80,".join(range(120,999),",")


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

" ESCを二回押すことでハイライトを消す
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

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

" delete が効かないときの設定
set backspace=indent,eol,start

"---------------------------------------------------------------------------
" Platform:
"

" クリップボード
if has('nvim')
  set clipboard+=unnamedplus
else
  set clipboard=unnamed,autoselect
endif

" マウス
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

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
" let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeWinSize=24
" 起動時にディレクトリならNERDTree、ファイルならファイルにフォーカスをあてる
let g:nerdtree_tabs_smart_startup_focus=1
" 新規タブを開いた時にもNERDTreeを表示する
let g:nerdtree_tabs_open_on_new_tab=1
" <C-e>でNERDTreeをオンオフ
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
"隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

" indentLine
" 文字を変更
let g:indentLine_char = '⁚'
" 色の変更
let g:indentLine_color_term = 239

" vim-trailing-whitespace
" 保存時に行末の空白を削除
autocmd BufWritePre * :FixWhitespace

" neosnippet
" snippetの展開
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" syntastic
" 初期設定
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
" pythonの文法チェック
let g:syntastic_python_checkers = ["flake8"]

" vim-smartchr
" 連続入力設定
inoremap <buffer> <expr> = smartchr#loop('=', ' = ', ' == ')
inoremap <buffer> <expr> <S-=> smartchr#loop('+', ' + ')
inoremap <buffer> <expr> - smartchr#loop('-', ' - ')
inoremap <buffer> <expr> , smartchr#loop(',', ', ')
inoremap <buffer> <expr> . smartchr#loop('.', '<%=  %>', '<%  %>')

" open-browser.vim
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)

" dash.vim
nmap <Leader>d <Plug>DashSearch


"---------------------------------------------------------------------------
" Others:
"

" プリント時の行番号の表示、余白
set printoptions=number:y,left:5pc
" プリント時のフォント
set printfont=Ricty\ for\ Powerline\ 12
