export JAVA_HOME=$(/usr/libexec/java_home)
export GOPATH=/Users/hashamali/gocode
export PATH=/Users/hashamali/bin:$PATH
export PATH=/usr/include:$PATH
export PATH=/opt/local/bin:$PATH

# IP forwarding setup
ipforwarding() {
	for i in {9000..9100}; do
		VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
		VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
	done
}

# boot2docker alias
alias b2d=boot2docker

# docker-compose alias
alias compose=docker-compose

# extract git branch info
parse_git_branch() {
  git_branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ $git_branch ]; then
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
	export PS1="$RED\$(date +%H:%M) $YELLOW\w$GREEN $(parse_git_branch) $CLEAR $ "
}

function gch {
        git checkout $1 && gsu
}

function gsu {
        git submodule init && git submodule update
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PROMPT_COMMAND=update_cmdline
