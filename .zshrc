# Alias
## General
alias ll=' ls -la'
alias ls=' ls -GF'
alias sz=' source ~/.zshrc'
alias cl=' clear'
alias v=' vim'

## Git
alias gs=' git status'
alias gb=' git branch'
alias gc=' git checkout'
alias ga=' git add'
alias gcm=' git commit -m'
alias gca=' git commit --amend'
alias gp=' git push'
alias gl=' git log --oneline -10'
alias gst=' git stash'

## Ruby on Rails
alias be=' bundle exec'
alias rr=' bundle exec rails routes | peco'
alias ss=' bin/spring stop'
alias rubo=' bundle exec rubocop --fail-level W --display-only-fail-level-offenses && bundle exec rubocop -A'

# Color
export LSCOLORS=gxfxcxdxbxegedabagacad
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# Completion
autoload -U compinit
compinit
## 小文字で大文字がヒットするが逆はしない
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} r:|[-_.]=**' '+m:{A-Z}={a-z} r:|[-_.]=**'
zstyle ':completion:*:default' menu select=1 # select with cursor

# Prompt
## Git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ":vcs_info:*" enable git
zstyle ':vcs_info:git:*' check-for-changes true  # enable %c %u
zstyle ':vcs_info:git:*' stagedstr "%F{175}"    # detect staged file
zstyle ':vcs_info:git:*' unstagedstr "%F{229}"  # detect unstaged file
zstyle ':vcs_info:*' formats "%F{115}▷ %c%u%b%f" # set $vsc_info_msg_0_
zstyle ':vcs_info:*' actionformats '[%b|%a]'     # detect conflict
precmd(){ vcs_info }

PROMPT='%F{115}%~%f %F{115}$vcs_info_msg_0_%f
%F{115}$%f '

# Prompt only git diff
# setopt prompt_subst
# precmd () {
#   if [ -n "$(git status --short 2>/dev/null)" ];then
#     export GIT_HAS_DIFF="✗"
#     export GIT_NON_DIFF=""
#   else
#     export GIT_HAS_DIFF=""
#     export GIT_NON_DIFF="✔"
#   fi
#   # git管理されているか確認
#   git status --porcelain >/dev/null 2>&1
#   if [ $? -ne 0 ];then
#     export GIT_HAS_DIFF=""
#     export GIT_NON_DIFF=""
#   fi
#   export BRANCH_NAME=$(git branch --show-current 2>/dev/null)
# }
# # 末尾に空白をつけることで改行される
# PROMPT="%F{115}%~%f"
# PROMPT=${PROMPT}'%F{115} :: ${BRANCH_NAME} ${GIT_NON_DIFF}%F{175}${GIT_HAS_DIFF}
# %f$ '

# History
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(vim|ls|pwd|exit)"
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

# peco

## history
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER" --prompt "history >")
  CURSOR=$#BUFFER
}
zle -N peco-select-history
bindkey '^r' peco-select-history

## cd past
function peco-cdr () {
  local selected_dir="$(cdr -l | awk '{ print $2 }' | peco --query "$LBUFFER" --prompt "cdr >")"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-cdr
bindkey '^w' peco-cdr

### cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*:*:cdr:*:*' menu selection
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-max 500
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
  zstyle ':chpwd:*' recent-dirs-pushd true
fi

## branch
function peco-git-checkout {
  git branch | peco --prompt "git >" | xargs git checkout
}
zle -N peco-git-checkout
bindkey '^o' peco-git-checkout

## open-with-vim
function peco-vim () {
  local selected_file=$(find . | peco --prompt "vim >" --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    BUFFER=" vim ${selected_file}"
  fi
}
zle -N peco-vim
bindkey '^u' peco-vim

## with ghq
function peco-ghq () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER" --prompt "ghq >")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ghq
bindkey '^]' peco-ghq

# ワイルドカードを使用してコマンドを実行する
setopt nonomatch

# ローカル環境毎の設定ファイルを読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
