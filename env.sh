#!/bin/bash

cd /tmp
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
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz
rclone copy anggitjav:Spark rom.tar.gz /tmp -P
time tar xf rom.tar.gz
rm -rf rom.tar.gz
cat /etc/os*
env
nproc
