# ZSH variable setting {{{

# Set name of the theme to load.
ZSH_THEME="powerline"

POWERLINE_DEFAULT_USER=$USER

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Update every two week
export UPDATE_ZSH_DAYS=14

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sublime bundler osx rake rails ruby fasd z)

# }}}


# User configuration {{{ 

# Start byobu on when starting terminal
# byobu

# Coustomize highlight in zsh
if [ "$TERM" = xterm ]; then TERM=xterm-256color; fi

# Environment variable setting {

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# PATH ENV
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/Users/timlentse/android-ndk-r13b:/Users/timlentse/Library/Python/2.7/bin"

# Set language environment
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"

# Set default editor
export EDITOR=vim

# Set rails environment
# export RAILS_ENV=development
export RAILS_ENV=development

# ssh
export SSH_KEY_PATH="~/.ssh"

#RAILS_ENV_SECRET
export SECRET_KEY_BASE="c8f73956e6c009fed776f919776c6424599e664e"

export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAletPlugin.plugin/Contents/Home
# }

# Theos env
export THEOS=/opt/theos
source $ZSH/oh-my-zsh.sh

# cd foo with `cd` 
setopt AUTO_CD

# Set alias command shortcut {
alias gs='git status'
alias bri='brew install'
alias bru='brew update'
alias brd='brew doctor'
# for linux {
alias sai='sudo apt-get install'
alias syi='sudo yum install'
# }
alias vz='vi ~/.zshrc'
alias vm='vi ~/.vimrc'
alias bi='sudo bundle install --verbose'
alias gi='sudo gem install --verbose'
alias gtr='cd "$(git rev-parse --show-toplevel)" '
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias vih='sudo vi /etc/hosts'
alias php-cli='php -a'
alias tail='tail -f'
# }

# Command highlight for zsh {
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

alias crontab="VIM_CRONTAB=true crontab"

# }

# }}}

