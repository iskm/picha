#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

. /etc/os-release

case $ID in
  "debian" )
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install vim git curl tmux stow ranger
    cd /home/admin/
    git clone git@github.com:iskm/dots.git
    mv .bashrc .bashrc.bak; mv .bash_profile .bash_profile.bak
    cd dots
    stow bash bin git shellenv tmux vim ranger
    ;;
  "rhel" )
    sudo dnf update -y
    ;;
esac

