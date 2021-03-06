"---------------------------------------------------------------------------
" Yasu's .vimrc
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" Encoding:
"

" 文字コード
set encoding=utf-8
" rcのエンコーディング
scriptencoding utf-8


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
  let s:ft_toml      = g:rc_dir . '/dein_ft.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:ft_toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  " 設定終了
  call dein#end()
  call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" プラグインのアップデート
"   call dein#update()

" シンタックス
syntax on

" filetypeプラグインによるindentをonにする
filetype plugin indent on

" Rictyフォントpowerline版
set guifont=Ricty\ for\ Powerline\ 14
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h14

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

" カーソル位置記憶
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

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
if (has("termguicolors"))
  set termguicolors
endif

" 起動時メッセージを表示しない
set shortmess& shortmess+=I

" カラースキーマ
" (tender, atom-dark-256, material-theme, OceanicNext)
if has('nvim')
  colorscheme tender
endif

" 絶対行番号表示
set number

" 相対行番号表示
" set relativenumber

" 行番号背景
hi LineNr guibg=#1D1F21
if has('nvim')
  hi LineNr guibg=#282828
endif

" タブページを常に表示
set showtabline=2

" ウィンドウ画面分割を右に
set splitright

" ウィンドウ画面分割を下に
set splitbelow

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
if has('nvim')
  " tender
  highlight ExtraWhitespace ctermbg=blue guibg=#73cef4
endif

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
      if has('nvim')
        " tender
        hi CursorLine term=underline cterm=underline gui=underline guibg=#323232
      endif
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
      if has('nvim')
        " tender
        hi CursorLine term=underline cterm=underline gui=underline guibg=#323232
      endif
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END　

" ウィンドウの境界線の設定
" set fillchars+=vert:\⎢
set fillchars=""
" atom
hi! VertSplit ctermfg=235 ctermbg=235 term=NONE guifg=#1d1f21
if has('nvim')
  " tender
  hi! VertSplit ctermfg=none ctermbg=none term=NONE guifg=#282828
endif

" 初期起動時の空行のチルダや改行文字の設定(NonText:eol,extends,precedes)
" atom
hi! NonText ctermfg=234 ctermbg=234 term=NONE guifg=#1D1F21 guibg=#1D1F21
if has('nvim')
  " tender
  hi! NonText ctermfg=235 ctermbg=235 term=NONE guifg=#323232
  " hi! link EndOfBuffer Ignore
  hi! EndOfBuffer gui=none guifg=#282828 guibg=none
  " hi! EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none
endif



" Wrap Guide(80:warning, 120:danger)
set textwidth=80
set colorcolumn=+1
" atom
hi ColorColumn guibg=#242728
if has('nvim')
  " tender
  hi ColorColumn guibg=#323232
endif
let &colorcolumn="80,".join(range(120,999),",")

" 自動改行OFF
set formatoptions=q

" iTerm2でtmuxを使っている時にインサートモードでのカーソルの形状をかえる
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" ヴィジュアル選択範囲カラー
if has('nvim')
  " tender
  hi Visual guifg=NONE ctermfg=NONE guibg=#335261 ctermbg=0 gui=NONE cterm=NONE
  hi VisualNOS guifg=NONE ctermfg=NONE guibg=#335261 ctermbg=0 gui=NONE cterm=NONE
endif

" 検索ハイライトカラー
if has('nvim')
  " tender
  hi IncSearch guifg=#f43753 ctermfg=235 guibg=NONE ctermbg=15 gui=NONE cterm=NONE
  hi Search guifg=#ffffff ctermfg=15 guibg=#f43753 ctermbg=NONE gui=underline,bold cterm=underline,bold
endif


" タブラインカラー
" if has('nvim')
  " tender
  " hi TabLine guifg=#f43753 ctermfg=246 guibg=#444444 ctermbg=238 gui=NONE cterm=NONE
  " hi TabLineFill guifg=NONE ctermfg=NONE guibg=#444444 ctermbg=238 gui=NONE cterm=NONE
  " hi TabLineSel guifg=#f43753 ctermfg=246 gui=NONE
" endif

" 背景半透明
if !has('gui_running')
    augroup seiya
        autocmd!
        autocmd VimEnter,ColorScheme * highlight Normal guibg=none
        autocmd VimEnter,ColorScheme * highlight LineNr guibg=none
        autocmd VimEnter,ColorScheme * highlight SignColumn guibg=none
        autocmd VimEnter,ColorScheme * highlight VertSplit guibg=none
        autocmd VimEnter,ColorScheme * highlight NonText guibg=none
    augroup END
endif

"---------------------------------------------------------------------------
" FileType:
"

" vim
autocmd FileType vim setlocal tabstop=2 shiftwidth=2

" javascript
function! s:javascript_filetype_settings()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal cindent
endfunction
autocmd FileType javascript,json call s:javascript_filetype_settings()
" autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile *.jsx set filetype=javascript.jsx

" html
function! s:html_filetype_settings()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal includeexpr=substitute(v:fname,'^\\/','','') |
endfunction
autocmd FileType html call s:html_filetype_settings()

" css
function! s:css_filetype_settings()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal cindent
endfunction
autocmd FileType css  call s:css_filetype_settings()

" php
" 文字列中のSQLをハイライト
let php_sql_query           = 1
" Baselibメソッドのハイライト
let php_baselib             = 1
" 文字列中のHTMLをハイライト
let php_htmlInStrings       = 1
" <? をハイライト除外にする
" let php_noShortTags         = 1
" カッコが閉じていない場合にハイライト
" let php_parent_error_close  = 1

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
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" vnoremap { "zdi^V{<C-R>z}<ESC>
" vnoremap [ "zdi^V[<C-R>z]<ESC>
" vnoremap ( "zdi^V(<C-R>z)<ESC>
" vnoremap " "zdi^V"<C-R>z^V"<ESC>
" vnoremap ' "zdi'<C-R>z'<ESC>

" F3で行番号の絶対行数/相対行数の変更"
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" タブ
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

"<leader>]で現在のファイルをChomeで開く
nnoremap <leader>] :silent !open -a Google\ Chrome %<CR>


"---------------------------------------------------------------------------
" Commands:
"

" delete が効かないときの設定
set backspace=indent,eol,start

" matchit.vimの有効化
if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
      let l:arg = "."
  else
      let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction
command! Qj call s:Qj()
function! s:Qj() abort
  %s/\(\n\|\s\)//g
endfunction

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
" neovim
set mouse=a

"
"---------------------------------------------------------------------------
" Plugin:
"

" NERDTree
" ディレクトリ表示記号
let g:NERDTreeDirArrows = 1
" 
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
" nmap <silent> <C-e>      :NERDTreeToggle<CR>
" vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
" omap <silent> <C-e>      :NERDTreeToggle<CR>
" <C-e>でNERDTreeをオンオフ(タブ間で共有)
nmap <silent> <C-e>      :NERDTreeTabsToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeTabsToggle<CR>
omap <silent> <C-e>      :NERDTreeTabsToggle<CR>
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" 開始時の余分な説明を消す
let NERDTreeMinimalUI=1
" autocmd filetype nerdtree hi Normal guibg=#282828

" Vimfiler
nnoremap <Leader>fe :<C-u>VimFilerExplorer<CR><C-u>
nnoremap <Leader>fc :<C-u>VimFilerCurrentDir<CR><C-u>
nnoremap <Leader>fb :<C-u>VimFilerBufferDir<CR><C-u>

" indentLine
" 文字を変更('˖', "•", '⁚', '︙', '┊', "│", "")
let g:indentLine_char = '˖'
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
" 自分用 snippet
let s:my_snippet = '~/.vim/snippets/'
let g:neosnippet#snippets_directory = s:my_snippet

" neocomplete & deoplete
if !has('nvim')
  " 起動
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
else
  let g:deoplete#enable_at_startup = 1
endif
" 説明ウィンドウを補完決定時に閉じる
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" 説明ウィンドウを常に閉じる
set completeopt-=preview


" syntastic
" 初期設定
" let g:syntastic_enable_signs=1
" let g:syntastic_auto_loc_list=2
" let g:syntastic_python_checkers = ["flake8", "pep8"]
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
" let g:syntastic_javascript_checker = ['jshint']
" エラー時のアイコン "⚑", "⚠", "●•"
" let g:syntastic_error_symbol = '●'
" let g:syntastic_style_error_symbol = '●'
" let g:syntastic_warning_symbol = '●'
" let g:syntastic_style_warning_symbol = '●'
" カラー
" if has('nvim')
  " tender
  " highlight SignColumn guibg=#282828
  " hi SyntasticErrorSign guibg=#282828 guifg=#f43753
  " hi SyntasticWarningSign guibg=#282828 guifg=#ffc24b
  " hi SignColumn guibg=none
  " hi SyntasticErrorSign guibg=none guifg=#f43753
  " hi SyntasticWarningSign guibg=none guifg=#ffc24b
  " hi SyntasticErrorLine guibg=#79313c
  " hi SyntasticWarningLine guibg=#715b2f
" endif

" ale
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \}
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
highlight ALEErrorSign guibg=none guifg=#f43753
highlight ALEWarningSign guibg=none guifg=#ffc24b
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_statusline_format = ['● %d', '/ %d', '']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" vim-smartchr
" 連続入力設定
inoremap <expr> = smartchr#loop('=', ' = ', ' == ', ' === ')
inoremap <expr> <S-=> smartchr#loop('+', ' + ')
inoremap <expr> - smartchr#loop('-', ' - ')
inoremap <expr> , smartchr#loop(',', ', ')
inoremap <expr> . smartchr#loop('.', '<%=  %>', '<%  %>')
inoremap <expr> < smartchr#loop('<', ' < ')
inoremap <expr> > smartchr#loop('>', ' > ', '->')

" open-browser.vim
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)

" dash.vim
nmap <Leader>d <Plug>DashSearch

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'tenderplus',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'ale' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'ale': 'ALEGetStatusLine'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'tabline_separator': { 'left': '', 'right': '' },
      \ 'tabline_subseparator': { 'left': '', 'right': '' },
      \ 'enable': { 'tabline': 0 }
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
let g:webdevicons_enable_unite = 1
let g:webdevicons_enable_vimfiler = 1
" ディレクトリアイコン
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''
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
autocmd filetype nerdtree highlight html_icon ctermbg=none ctermfg=red guifg=#D28445
autocmd filetype nerdtree syn match html_icon ## containedin=NERDTreeFile,html
autocmd filetype nerdtree highlight css_icon ctermbg=none ctermfg=blue guifg=#6A9FB5
autocmd filetype nerdtree syn match css_icon ## containedin=NERDTreeFile,css
autocmd filetype nerdtree highlight js_icon ctermbg=none ctermfg=yellow guifg=#90A959
autocmd filetype nerdtree syn match js_icon ## containedin=NERDTreeFile,js
autocmd filetype nerdtree highlight db_icon ctermbg=none ctermfg=yellow guifg=#F4BF75
autocmd filetype nerdtree syn match db_icon ## containedin=NERDTreeFile,db
autocmd filetype nerdtree highlight python_icon ctermbg=none ctermfg=blue guifg=#6A9FB5
autocmd filetype nerdtree syn match python_icon ## containedin=NERDTreeFile,py
autocmd filetype nerdtree highlight php_icon ctermbg=none ctermfg=cyan guifg=#6A9FB5
autocmd filetype nerdtree syn match php_icon ## containedin=NERDTreeFile,php
autocmd filetype nerdtree highlight ruby_icon ctermbg=none ctermfg=red guifg=#AC4142
autocmd filetype nerdtree syn match ruby_icon ## containedin=NERDTreeFile,rb
autocmd filetype nerdtree highlight swift_icon ctermbg=none ctermfg=magenta guifg=#75B5AA
autocmd filetype nerdtree syn match swift_icon ## containedin=NERDTreeFile,swift
autocmd filetype nerdtree highlight md_icon ctermbg=none ctermfg=magenta guifg=#AA759F
autocmd filetype nerdtree syn match md_icon ## containedin=NERDTreeFile,md
autocmd filetype nerdtree highlight sh_icon ctermbg=none ctermfg=green guifg=#90A959
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
" let g:evervim_devtoken='S=s105:U=b313cd:E=15cd466bea4:C=1557cb59190:P=1cd:A=en-devtoken:V=2:H=71e8d95e31a51e6c7a67364c44fc3e0c'
" nnoremap <Leader>l :EvervimNotebookList<CR>
" nnoremap <Leader>s :EvervimSearchByQuery<Space>
" nnoremap <Leader>c :EvervimCreateNote<CR>
" nnoremap <Leader>t :EvervimListTags<CR>

" vim-splash
let g:splash#path = $HOME . '/.vim/splashes/start.txt'

" tagbar
nmap <F8> :TagbarToggle<CR>

" tern_for_vim
let tern#is_show_argument_hints_enabled = 0
let g:tern_show_argument_hints='on_hold'
let g:tern_show_signature_in_pum = 0

" deoplete-ternjs
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" vim-jsx
let g:jsx_ext_required = 0

" vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.ejs'

" simple-javascript-indenter
let g:SimpleJsIndenter_BriefMode = 2

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-jsdoc
nmap <silent> <C-l> <Plug>(jsdoc)

" MatchTagAlways
" オプション機能ONにする
let g:mta_use_matchparen_group = 1
" 使用するファイルタイプ
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'php' : 1,
    \ 'vue' : 1,
    \}

" vim-easymotion
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" `s{char}{char}{label}`
nmap <C-m> <Plug>(easymotion-overwin-f2)
" Smartcase
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
" map <C-m> <Plug>(easymotion-prefix)

" fzf
let g:fzf_action = {
  \ 'ctrl-w': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" javascript-libraries-syntax.vim
function! EnableJavascript()
  " Setup used libraries
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,vue,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_vue = 1
  let b:javascript_lib_use_d3 = 1
endfunction
autocmd FileType javascript,javascript.jsx call EnableJavascript()

" vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1

" vim-jsx
let g:jsx_ext_required = 0

"---------------------------------------------------------------------------
" Others:
"

" プリント時の行番号の表示、余白
set printoptions=number:y,left:5pc
" プリント時のフォント
set printfont=Ricty\ for\ Powerline\ 12
