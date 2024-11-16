#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

. /etc/os-release

case $ID in
  "debian" )
    sudo apt update -y && sudo apt upgrade -y
    ;;
  "rhel" )
    sudo dnf update -y
    ;;
esac

