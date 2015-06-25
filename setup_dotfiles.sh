#!/bin/bash

# make sure dotfiles is in $HOME...
if [ ! -d 'dotfiles' ]; then
	echo "Please put dotfiles repo in $HOME directory."
	exit 1
fi	

pushd .

# add dotfiles to $HOME/* ...
cd $HOME/dotfiles
git ls-tree --full-tree HEAD | awk '{print $4}' | egrep '^\.' | xargs -0 -I file cp -r file $HOME/

retval=$?

if [ $retval -eq 0 ]; then
    echo "Done!"
else
    echo "Setup Failed: $retval"
fi
