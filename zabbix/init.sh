#!/bin/bash

IP=$1

echo "connect to "$IP
# sed -ig "s/$IP//g" ~/.ssh/known_hosts
# scp ~/.ssh/id_rsa.pub root@$IP:~/.ssh/authorized_keys

ssh root@$IP yum install -y git
ssh root@$IP dir system_settin || git clone https://github.com/edwardramsey/system_setting.git 
ssh root@$IP chmod +x ./system_setting/zabbix/*
# ssh root@$IP ./system_setting/zabbix/tool.sh
ssh root@$IP ./system_setting/zabbix/zabbix_config.sh -s

