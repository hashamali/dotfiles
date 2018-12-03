#############
### paths ###
#############

HOME_DIR="/Users/$(whoami)"

export JAVA_HOME=$(/usr/libexec/java_home)
export GOPATH=$HOME_DIR/go
export PATH=/Library/Frameworks/Python.framework/Versions/3.6/bin:$HOME_DIR/bin:/usr/include:/opt/local/bin:$HOME_DIR/Library/Android/sdk/platform-tools:$PATH


###############
### private ###
###############

if [ -f "${BASH_SOURCE%/*}/.bash_private" ]; then
  . "${BASH_SOURCE%/*}/.bash_private"
fi


############
### tmux ### 
############

work () {
  attach_tmux "work"
}

home () {
  attach_tmux "home"
}

attach_tmux () {
  tmux attach -t $1 || tmux new -s $1
}


############
### misc ###
############

# get ip address
alias getip="ipconfig getifaddr en0"

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

# git bfg
function bfg {
  java -jar /usr/local/bin/bfg-1.12.12.jar
}

# ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


###############
### aliases ###
###############

# python 
alias p3='/usr/local/bin/python3'

# git
alias gs='git status'
alias gd='git diff'
alias gco='git commit'
alias gch='git checkout'
alias gpl='git pull'
alias gps='git push'

# elixir
alias el='elixir'
alias mx='mix'


#####################
### custom prompt ###
#####################

# color consts
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
CLEAR="\[\033[0m\]"

# extract git branch info
parse_git_branch () {
  git_branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ $git_branch ] && [ $git_branch != *"bash"* ]; then
    echo "[$git_branch]"
  fi
}

# update cmdline to include time, dir, git info
function update_cmdline () {
  export PS1="$RED\$(date +%H:%M) $YELLOW\w$GREEN $(parse_git_branch) $CLEAR δ "
}

PROMPT_COMMAND=update_cmdline


##############
### gcloud ###
##############

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME_DIR/google-cloud-sdk/path.bash.inc" ]; then 
  source "$HOME_DIR/google-cloud-sdk/path.bash.inc" 
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME_DIR/google-cloud-sdk/completion.bash.inc" ]; then 
  source "$HOME_DIR/google-cloud-sdk/completion.bash.inc"
fi
