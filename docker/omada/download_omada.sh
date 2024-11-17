#!/usr/bin/env bash

wget https://static.tp-link.com/upload/software/2024/202411/20241115/Omada_SDN_Controller_v5.14.32.4_linux_x64.tar.gz -O omada_sdn.tar.gz
mkdir omada
tar xvf omada_sdn.tar.gz -C omada
rm -rf omada_sdn.tar.gz
