#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export ALLOW_MISSING_DEPENDENCIES=true
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf
DEBIAN_FRONTEND=noninteractive
sudo ln -sf /usr/bin/python3 /usr/bin/python
git config --global user.name "NFS86"
git config --global user.email "jarbull86@gmail.com"
mkdir -p /tmp/ccache
rclone copy anggitjav:ccache/rom/ccache.tar.gz /tmp -P
cd /tmp
time tar xf ccache.tar.gz
cd /tmp
cat /etc/os*
env
