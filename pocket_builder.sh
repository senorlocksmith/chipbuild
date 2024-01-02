#!/bin/bash
# PocketCHIP Builder Script
# Build 2

REPO="https://raw.githubusercontent.com/SteveMcGrath/chipbuild/master"

# To keep things nice and clean, we will build out a profile_scripts
# directory and source these files into the user's prompt.
if [ ! -d "$HOME/.profile_scripts" ];then
    echo "[*] Creating Profile Scripts Directory and Shimming $USER .bashrc"
    mkdir -p $HOME/.profile_scripts

    # This is the addition that we are adding into the users .bashrc.
    echo ''                                                                         >> $HOME/.bashrc
    echo '# This is a shim to allow for multiple profile script to exist in the'    >> $HOME/.bashrc
    echo '# user home.  All of the shell scripts in ~/.profile_scripts will be'     >> $HOME/.bashrc
    echo '# loaded into the user environment.'                                      >> $HOME/.bashrc
    echo 'for SCRIPT_NAME in $(ls $HOME/.profile_scripts/*.sh);do'                  >> $HOME/.bashrc
    echo '    source $SCRIPT_NAME'                                                  >> $HOME/.bashrc
    echo 'done'                                                                     >> $HOME/.bashrc
    echo 'unset SCRIPT_NAME'                                                        >> $HOME/.bashrc
fi

# If there isnt an aliases.sh file, then we will create one with some defaults added in.
if [ ! -f "$HOME/.profile_scripts/aliases.sh" ];then
    ALIASES=$HOME/.profile_scripts/aliases.sh
    echo "[*] Creating default aliases file"
    echo 'alias sshon="sudo systemctl start ssh"'               >  $ALIASES
    echo 'alias sshoff="sudo systemctl stop ssh"'               >> $ALIASES
    echo "alias getip=\"ip addr | awk '/inet/ {print $2}'\""    >> $ALIASES
    echo 'alias ll="ls -al"'                                    >> $ALIASES
    echo 'alias pgr="ps -ef | grep"'                            >> $ALIASES
    echo 'alias sagi="sudo apt-get install"'                    >> $ALIASES
    echo 'alias sagu="sudo apt-get update"'                     >> $ALIASES
    echo 'alias sags="apt-cache search"'                        >> $ALIASES
fi
