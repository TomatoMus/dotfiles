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

" filetypeプラグインによるindentをonにする
filetype plugin indent on

" Rictyフォントpowerline版
set guifont=Ricty\ for\ Powerline\ 14
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h14

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

" インクリメンタルサーチを行う
set incsearch

" 大文字小文字を区別しない
set ignorecase

" 大文字があるときは区別
set smartcase

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

" 背景色
" set background=dark

" truecolor
set termguicolors

" 起動時メッセージを表示しない
set shortmess& shortmess+=I

" カラースキーマ
colorscheme atom-dark-256
" colorscheme material-theme
" colorscheme tender

" 絶対行番号表示
set number

" 相対行番号表示
set relativenumber

" タブページを常に表示
set showtabline=2

"不可視文字の文字の可視化
set list
" set listchars=tab:»-,trail:˽·_,eol:¬,extends:»,precedes:«,nbsp:%
set listchars=tab:▸·,trail:·,eol:¬,extends:»,precedes:«

" 特殊記号の2byte割当
" set ambiwidth=double

" shiftwidth を設定することが可能に
set smarttab
" TABキーを押した際にスペースを入れる
set expandtab
" TABにいくつの空白を設定するか
set tabstop=4
" 自動インデントの際に用いられる各ステップの幅"
set shiftwidth=4

" 余分な空白の色
" atom
highlight ExtraWhitespace ctermbg=blue guibg=#92C5F7
" tender
" highlight ExtraWhitespace ctermbg=blue guibg=#73cef4

" ステータスラインを常時表示
set laststatus=2

" デフォルトのモードステータスの非表示
set noshowmode

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
      " hi CursorLine term=underline cterm=underline guibg=Grey90
      " atom
      hi CursorLine term=underline cterm=underline guibg=#242728
      " tender
      " hi CursorLine term=underline cterm=underline guibg=#323232
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
      " hi CursorLine term=underline cterm=underline guibg=Grey90
      " atom
      hi CursorLine term=underline cterm=underline guibg=#242728
      " tender
      " hi CursorLine term=underline cterm=underline guibg=#323232
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" ウィンドウの境界線の設定
set fillchars+=vert:\⎢
" atom
hi! VertSplit ctermfg=235 ctermbg=235 term=NONE guifg=#1d1f21 guibg=#1d1f21
" tender
" hi! VertSplit ctermfg=235 ctermbg=235 term=NONE guifg=#282828 guibg=#282828

" 初期起動時の空行のチルダの設定
" atom
hi! NonText ctermfg=234 ctermbg=234 term=NONE guifg=#1D1F21 guibg=#1D1F21
" tender
" hi! NonText ctermfg=235 ctermbg=235 term=NONE guifg=#282828 guibg=#282828



" Wrap Guide(80:warning, 120:danger)
set textwidth=80
set colorcolumn=+1
" atom
hi ColorColumn guibg=#242728
" tender
" hi ColorColumn guibg=#323232
let &colorcolumn="80,".join(range(120,999),",")

" 自動改行OFF
set formatoptions=q

" iTerm2でtmuxを使っている時にインサートモードでのカーソルの形状をかえる
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif


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

" F3で行番号の絶対行数/相対行数の変更"
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" タブ
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

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
if !has('nvim')
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
endif

"---------------------------------------------------------------------------
" Plugin:
"

" NERDTree
" ディレクトリ表示記号
let g:NERDTreeDirArrows = 1
" let g:NERDTreeDirArrowExpandable = '❐'
let g:NERDTreeDirArrowExpandable = ''
" let g:NERDTreeDirArrowCollapsible = '▿'
let g:NERDTreeDirArrowCollapsible = ''
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
" let g:indentLine_color_gui = '#303435'
let g:indentLine_color_gui = '#60696B'
" 横線
" let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_leadingSpaceEnabled = 1

" vim-trailing-whitespace
" 保存時に行末の空白を削除
autocmd BufWritePre * :FixWhitespace

" neosnippet
" snippetの展開
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" neocomplete
" 起動
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" syntastic
" 初期設定
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
" let g:syntastic_error_symbol = '✗'
let g:syntastic_error_symbol='⚑'
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

" lightline.vim
    " \ 'colorscheme': 'tender',
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'tabline_separator': { 'left': '', 'right': '' },
    \ 'tabline_subseparator': { 'left': '', 'right': '' }
    \ }
" lightlineでdeviconを表示
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
" ファイルの変更状態
function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction
" ファイルの権限
function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction
" ファイルのGitの状態
function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
    " return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction
" ファイル名
function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
" ディレクトリアイコン
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:DevIconsEnableFoldersOpenClose = 1
" let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
" let g:DevIconsDefaultFolderOpenSymbol = ''
" ファイル別アイコン
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['swift'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
" ファイル別アイコンカラー
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
autocmd filetype nerdtree highlight html_icon ctermbg=none ctermfg=red
autocmd filetype nerdtree syn match html_icon ## containedin=NERDTreeFile,html
autocmd filetype nerdtree highlight css_icon ctermbg=none ctermfg=blue
autocmd filetype nerdtree syn match css_icon ## containedin=NERDTreeFile,css
autocmd filetype nerdtree highlight js_icon ctermbg=none ctermfg=yellow
autocmd filetype nerdtree syn match js_icon ## containedin=NERDTreeFile,js
autocmd filetype nerdtree highlight db_icon ctermbg=none ctermfg=yellow
autocmd filetype nerdtree syn match db_icon ## containedin=NERDTreeFile,db
autocmd filetype nerdtree highlight python_icon ctermbg=none ctermfg=blue
autocmd filetype nerdtree syn match python_icon ## containedin=NERDTreeFile,py
autocmd filetype nerdtree highlight php_icon ctermbg=none ctermfg=cyan
autocmd filetype nerdtree syn match php_icon ## containedin=NERDTreeFile,php
autocmd filetype nerdtree highlight ruby_icon ctermbg=none ctermfg=red
autocmd filetype nerdtree syn match ruby_icon ## containedin=NERDTreeFile,rb
autocmd filetype nerdtree highlight swift_icon ctermbg=none ctermfg=magenta
autocmd filetype nerdtree syn match swift_icon ## containedin=NERDTreeFile,swift
autocmd filetype nerdtree highlight md_icon ctermbg=none ctermfg=magenta
autocmd filetype nerdtree syn match md_icon ## containedin=NERDTreeFile,md
autocmd filetype nerdtree highlight sh_icon ctermbg=none ctermfg=green
autocmd filetype nerdtree syn match sh_icon ## containedin=NERDTreeFile,sh

" vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}
augroup vim-anzu
" 一定時間キー入力がないとき、ウインドウを移動したとき、タブを移動したときに
" 検索ヒット数の表示を消去する
    autocmd!
    autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

" evervim
let g:evervim_devtoken='S=s105:U=b313cd:E=15cd466bea4:C=1557cb59190:P=1cd:A=en-devtoken:V=2:H=71e8d95e31a51e6c7a67364c44fc3e0c'
nnoremap <Leader>l :EvervimNotebookList<CR>
nnoremap <Leader>s :EvervimSearchByQuery<Space>
nnoremap <Leader>c :EvervimCreateNote<CR>
nnoremap <Leader>t :EvervimListTags<CR>

" vim-splash
let g:splash#path = $HOME . '/.vim/splashes/start.txt'


"---------------------------------------------------------------------------
" Others:
"

" プリント時の行番号の表示、余白
set printoptions=number:y,left:5pc
" プリント時のフォント
set printfont=Ricty\ for\ Powerline\ 12

