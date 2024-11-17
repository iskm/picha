#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

. /etc/os-release

case $ID in
  "debian" )
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install -y  vim git curl tmux stow ranger
    cd /home/admin/
    git clone https://github.com/iskm/dots.git 
    if [[ -e .bashrc  ]]; then mv .bashrc .bashrc.bak; fi
    if [[ -e .bash_profile ]]; then mv .bash_profile .bash_profile.bak; fi
    cd dots
    stow bash bin git shellenv tmux vim ranger
    ;;
  "rhel" )
    sudo dnf update -y
    ;;
esac

