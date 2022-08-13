############
### tmux ### 
############

tm () {
  tmux attach -t $1 || tmux new -s $1
}


############
### misc ###
############

# get local ip address
alias ip="ipconfig getifaddr en0"

# move up in directory
function up {
  if [[ "$#" < 1 ]] ; then
    cd ..
  else
    CDSTR=""
    for i in {1..$1} ; do
      CDSTR="../$CDSTR"
    done
    cd $CDSTR
  fi
}

function urlencode() {
  python -c 'import urllib, sys; print urllib.quote(sys.argv[1], sys.argv[2])' \
    "$1" "$urlencode_safe"
}


###############
### aliases ###
###############

# python 
alias p3='/usr/local/bin/python3'

# git
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git commit'
alias gch='git checkout'
alias gpl='git pull'
alias gps='git push'


#####################
### custom prompt ###
#####################

autoload -U colors && colors
setopt PROMPT_SUBST

# color consts
RED="\e[0;31m"
YELLOW="\e[0;33m"
GREEN="\e[0;32m"
CLEAR="\e[0m"

# extract git branch info
parse_git_branch () {
  git_branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [[ $git_branch && $git_branch != *"bash"* && $git_branch != *"detached"* ]]; then
    echo "[$git_branch]"
  fi
}

# update cmdline to include time, dir, git info
function precmd () {
  export PS1="%{$fg[red]%}$(date +%r) %{$fg[yellow]%} %~ %{$fg[green]%}$(parse_git_branch) %{$reset_color%}%  "
}

[[ -n $TMUX ]] && export TERM="xterm-256color"
