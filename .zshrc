# Path to your oh-my-zsh installation.
export ZSH=/Users/mattward/.oh-my-zsh

# User 256-colors mode
export TERM="xterm-256color"

ZSH_THEME="agnoster"

# Hyphen-insensitive completion
HYPHEN_INSENSITIVE="true"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Preferred editor
export EDITOR='vim'

# add the 'z' script
. `brew --prefix`/etc/profile.d/z.sh

export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

# use fd when fuzzy searching with fzf to respect .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export DEFAULT_USER="mattward"
export AWS_USERNAME="matt.ward"

# this must go at the end of the file
source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# alias
source ~/.alias

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
