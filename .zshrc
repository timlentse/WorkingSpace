# Path to your oh-my-zsh installation.
export ZSH=/Users/timlen/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="powerline"

POWERLINE_DEFAULT_USER=$USER

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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
plugins=(git bundler osx rake rails ruby fasd)

# User configuration

# PATH ENV
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Start byobu on when starting terminal
# byobu

source $ZSH/oh-my-zsh.sh

# Coustomize highlight in zsh
if [ "$TERM" = xterm ]; then TERM=xterm-256color; fi

# Set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
#

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set alias command shortcut {
alias gs='git status'
alias rm='rm -rf'
alias bri='brew install'
alias bru='brew update'
alias brd='brew doctor'
alias sdi='sudo apt-get install'
alias vz='vi ~/.zshrc'
alias vm='vi ~/.vimrc'
alias bi='sudo bundle install --verbose'
alias gi='sudo gem install --verbose'
# }

# Command highlight for zsh
setopt extended_glob
TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

recolor-cmd() {
  region_highlight=()
  colorize=true
  start_pos=0
  for arg in ${(z)BUFFER}; do
    ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
    ((end_pos=$start_pos+${#arg}))
    if $colorize; then
      colorize=false
      res=$(LC_ALL=C builtin type $arg 2>/dev/null)
      case $res in
        *'reserved word'*)   style="fg=magenta,bold";;
        *'alias for'*)       style="fg=cyan,bold";;
        *'shell builtin'*)   style="fg=yellow,bold";;
        *'shell function'*)  style='fg=green,bold';;
        *"$arg is"*)
          [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
        *)                   style='none,bold';;
      esac
      region_highlight+=("$start_pos $end_pos $style")
    fi
    [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
    start_pos=$end_pos
  done
}
check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char
