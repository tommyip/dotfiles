# Author: Tommy Ip
# OS: Linux Mint 18

export ZSH=/home/tommy/.oh-my-zsh

ZSH_THEME="materialshell-oceanic"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
HYPHEN_INSENSITIVE="true"

export USER="$tommy"
export PATH="
/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/cuda/bin:
$HOME/neovim/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/Documents/scripts:$PATH
"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export UPDATE_ZSH_DAYS=7
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/"
export LESS=' -R '
export EDITOR='nvim'
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
export RUST_SRC_PATH="/home/tommy/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
fpath+=~/.zfunc

source $ZSH/oh-my-zsh.sh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias vi="nvim"
alias c="clear"
alias rz="source ~/.zshrc"
alias clock="tty-clock -C 2"
alias py="python3"
alias up="sudo apt update && sudo apt upgrade"
alias chrome="google-chrome"
alias dc="docker-compose"
alias gpr="git pull --rebase upstream master"
alias open="xdg-open"

eval $(thefuck --alias)

dockerRmAllImg() {
    containers=$(docker images | rg '[a-z0-9]{12}' -o)
    if [ -z $containers ]; then
        echo "There are no containers to delete"
    else
        docker rmi -f $containers
    fi
}

unsetopt correct_all
setopt correct
setopt no_extended_glob

source ~/.zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"

if ! zplug check --verbose; then
  printf "Install? [y/n]: "
  if read -q; then
	  echo; zplug install
  fi
fi

zplug load --verbose
