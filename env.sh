#!/bin/bash

cd /tmp
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf
mkdir -p /tmp/ccache
rclone copy NFS:ccache/rom/ccache.tar.gz /tmp -P
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz

mkdir -p /tmp/rom
rclone copy NFS:ccache/rom/out.tar.gz /tmp/rom -P
cd /tmp/rom
time tar xf out.tar.gz
rm -rf out.tar.gz
cat /etc/os*
env
nproc
gcc --version
clang --version
cd /tmp
