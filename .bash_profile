export JAVA_HOME=$(/usr/libexec/java_home)
export GOPATH=/Users/hashamali/gocode
export PATH=/Users/hashamali/bin:$PATH
export PATH=/usr/include:$PATH
export PATH=/opt/local/bin:$PATH
export HAXEPATH=/usr/local/bin/

# tmux management
work() {
	attachtmux "work"
}

home() {
	attachtmux "home"
}

attachtmux() {
	tmux attach -t $1 || tmux new -s $1
}

# helpful commands
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

# docker management
alias compose=docker-compose
alias machine=docker-machine

# extract git branch info
parse_git_branch() {
  git_branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ $git_branch ] && [ $git_branch != *"bash"* ]; then
    echo "[$git_branch]"
  fi
}

# color consts
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
CLEAR="\[\033[0m\]"

# update cmdline to include time, dir, git info
function update_cmdline() {
	export PS1="$RED\$(date +%H:%M) $YELLOW\w$GREEN $(parse_git_branch) $CLEAR δ "
}

function gch {
        git checkout $1 && gsu
}

function gsu {
        git submodule init && git submodule update
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PROMPT_COMMAND=update_cmdline
