# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#[alias]
# alias vi='vim'
alias vi='nvim'
# alias emacs="/usr/local/bin/emacs"
alias mvi="mvim --remote-tab-silent"
alias up='cd ..'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# phコマンドで意味表示
# ZSH_THEME="wedisagree"
ZSH_THEME="spaceship"
# ZSH_THEME="materialshelldark"
# ZSH_THEME="agnoster"
# ZSH_THEME="avit"
# ZSH_THEME="theunraveler"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

###original setting
# path
export PATH=/usr/local/bin:/usr/bin:$PATH

# peco setting
# function peco-select-history() {
#     local tac
#     if which tac > /dev/null; then
#         tac="tac"
#     else
#         tac="tail -r"
#     fi
#     BUFFER=$(\history -n 1 | \
#         eval $tac | \
#         peco --query "$LBUFFER")
#     CURSOR=$#BUFFER
#     zle clear-screen
# }
# zle -N peco-select-history
# bindkey '^r' peco-select-history

# wedisagree setting
function ph() {
  local prompt_descriptions
  prompt_descriptions=(
    $ZSH_THEME_GIT_PROMPT_DIRTY 'dirty\tclean でない'
    $ZSH_THEME_GIT_PROMPT_UNTRACKED 'untracked\tトラックされていないファイルがある'
    $ZSH_THEME_GIT_PROMPT_CLEAN 'clean'
    $ZSH_THEME_GIT_PROMPT_ADDED 'added\t追加されたファイルがある'
    $ZSH_THEME_GIT_PROMPT_MODIFIED 'modified\t変更されたファイルがある'
    $ZSH_THEME_GIT_PROMPT_DELETED 'deleted\t削除されたファイルがある'
    $ZSH_THEME_GIT_PROMPT_RENAMED 'renamed\tファイル名が変更されたファイルがある'
    $ZSH_THEME_GIT_PROMPT_UNMERGED 'unmerged\tマージされていないファイルがある'
    $ZSH_THEME_GIT_PROMPT_AHEAD 'ahead\tmaster リポジトリよりコミットが進んでいる'
  )

  local i
  for ((i = 1; i <= $#prompt_descriptions; i += 2))
  do
    local p=$prompt_descriptions[$i]
    local d=$prompt_descriptions[$i+1]
    echo `echo $p | sed -E 's/%.| //g'` $reset_color $d
  done
}

# gvim newtab
# export PATH="$HOME/.anyenv/bin:$PATH"


export PATH=/Applications/MAMP/bin/php/php7.0.10/bin:$PATH
# export PATH=/usr/local/etc/clamav/:/usr/local/Cellar/php55/5.5.29/bin:/usr/local/Cellar/php55/5.5.29/bin/pear:/usr/local/Cellar/php55/5.5.29:/usr/local/opt/icu4c/lib:/usr/local/opt/icu4c/include:$PATH
# eval "$(anyenv init - zsh)"

# install go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# cdなしでディレクトリ名を直接指定して移動
# cd したら ls
setopt auto_cd
function chpwd(){ ls }

# vim のエンコード問題対策
# for F in ~/.vim/bundle/rsense/doc/*.ja.txt; do
#     mv $F $F:r:r.jax
# done


# tmuxの自動起動
# 最終ログイン時につないでいたセッションにアタッチ。なければ新規セッション
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            # echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            # echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            # echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            # echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            # echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session


# warningに対する対処
# .oh-my-zsh/completions
#fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
#fpath=(/path/to/homebrew/share/zsh-completions $fpath)
#autoload -U compinit
#compinit -u

# pyenvの環境パス
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# rbenvの環境パス
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# phpenvの環境パス
# export PATH="$HOME/.phpenv/bin:$PATH"
# eval "$(phpenv init -)"

# neovim
export XDG_CONFIG_HOME=$HOME/.config

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# node.jsのパス
export PATH=$PATH:$HOME/.nodebrew/current/bin

# mampのmysql
export PATH=$PATH:/Applications/MAMP/Library/bin

# qt5 of cmake for citra
export CMAKE_PREFIX_PATH=/usr/local/Cellar/qt5/5.7.0/lib/cmake:$CMAKE_PREFIX_PATH

# valet
export PATH=$PATH:$HOME/.composer/vendor/bin

# go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


# fzf
function history-fzf() {
    local tac=${commands[tac]:-"tail -r"}
    BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | eval $tac | awk '!a[$0]++' | fzf-tmux +s)
    CURSOR=$#BUFFER
}
zle     -N   history-fzf
bindkey '^R' history-fzf

function ghq-fzf() {
  local selected_dir=$(ghq list | fzf-tmux --query="$LBUFFER" )
  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N ghq-fzf
bindkey "^G" ghq-fzf

function tree-fzf() {
  local SELECTED_FILE=$(tree --charset=o -f | fzf-tmux --query "$LBUFFER" | tr -d '\||`|-' | xargs echo)
  if [ "$SELECTED_FILE" != "" ]; then
    BUFFER="$EDITOR $SELECTED_FILE"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N tree-fzf
bindkey "^T" tree-fzf


function git-branch-fzf() {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | perl -pne 's{^refs/heads/}{}' | fzf-tmux --query "$LBUFFER" )
  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N git-branch-fzf
bindkey "^B" git-branch-fzf

function ssh-fzf () {
  local selected_host=$(grep "Host " ~/.ssh/config | grep -v '*' | cut -b 6- | fzf-tmux --query "$LBUFFER" )
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N ssh-fzf
bindkey '^\' ssh-fzf

export FZF_DEFAULT_OPTS='--reverse'

