#!/usr/bin/env bash

function install_prereqs() {
  sudo apt install -y jsvc curl default-jre default-jdk
  sudo apt-get install gnupg curl -y
}

function install_mongodb () {
  curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
  sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
    --dearmor
  echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg  ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
  sudo apt-get update -y
  sudo apt-get install -y mongodb-org
}

install_prereqs
install_mongodb
cd omada/Omada_SDN_Controller_v5.14.32.4_linux_x64/ || exit
sudo ./install.sh

