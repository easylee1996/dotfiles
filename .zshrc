# 禁用插件目录安全检查
ZSH_DISABLE_COMPFIX=true


export ZSH="$HOME/.oh-my-zsh"
export HF_ENDPOINT="https://hf-mirror.com"
export Documents="D:/"

# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# spaceship-prompt主题windows配置有点问题，暂时用powerlevel10k
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# 这里添加了文件夹，如果不想写文件夹名称，可以使用ln软连接把文件夹链接到oh-my-zsh/custom/themes目录下
ZSH_THEME="powerlevel10k/powerlevel10k"
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
# Mac和linux还可以安装：autojump/copydir/copyfile，windows先不折腾了，有空有需要可以再折腾
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

# ================================================================================================
# = Node Package Manager =====================================
# ================================================================================================
# https://github.com/antfu/ni

alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias p="nr play"
# alias c="nr typecheck"
alias c="nr compress"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"

# ================================================================================================
# = GIT =====================================
# ================================================================================================

# Use github/hub
# brew install hub
alias git=hub

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'
alias grbom='git rebase origin/master'
alias grbc='git rebase --continue'

alias gl='git log'
alias glo='git log --oneline --graph'

alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'

alias ga='git add'
alias gA='git add -A'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git add -A && git commit -m'
alias gfrb='git fetch origin && git rebase origin/master'

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'

function glp() {
  git --no-pager log -$1
}

function gd() {
  if [[ -z $1 ]] then
    git diff --color | diff-so-fancy
  else
    git diff --color $1 | diff-so-fancy
  fi
}

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
}

# ================================================================================================
# = Directories =====================================
# ================================================================================================
# I put
# `$Documents/pj/mypj` for my projects
# `$Documents/pj/fork` for forks
# `$Documents/pj/reproduction` for reproductions



function i() {
  cd $Documents/pj/mypj/$1
}

function repro() {
  cd $Documents/pj/reproduction/$1
}

function fork() {
  cd $Documents/pj/fork/$1
}

function work() {
  open $Documents/work/$1
}

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  # is not empty: -z
  if [[ -z $2 ]] then
    hub clone "$@" && cd "$(basename "$1" .git)"
  else
    hub clone "$@" && cd "$2"
  fi
}

# Clone to $Documents/pj/mypj and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function cloner() {
  repro && clone "$@" && code . && cd ~2
}

function clonef() {
  fork && clone "$@" && code . && cd ~2
}

function codei() {
  i && code "$@" && cd -
}

function serve() {
  if [[ -z $1 ]] then
    live-server dist
  else
    live-server $1
  fi
}

# Default Proxy
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890

# https://ohmyz.sh/
# tip: need to put after path
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# windows环境下，conda虚拟环境，必须添加下面的配置，才可以正常使用虚拟环境，默认使用conda init zsh是错误的
# @see {@link https://github.com/conda/conda/issues/9922#issuecomment-1361695031 github} 
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval "$('/c/ProgramData/miniconda3/Scripts/conda.exe' 'shell.zsh' 'hook' | sed -e 's/"$CONDA_EXE" $_CE_M $_CE_CONDA "$@"/"$CONDA_EXE" $_CE_M $_CE_CONDA "$@" | tr -d \x27\\r\x27/g' | tr -d '\r')"
# <<< conda initialize <<<

