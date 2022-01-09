#!/bin/bash

cd /tmp
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf

function rcloneccache() {
mkdir -p /tmp/ccache
rclone copy NFS:ccache/arcanaos/ccache.tar.gz /tmp -P
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz
}

function rclonemanifest() {
mkdir -p /tmp/rom
rclone copy NFS:ccache/arcanaos/rom.tar.gz /tmp -P
cd /tmp
time tar xf rom.tar.gz
rm -rf rom.tar.gz
}

function rcloneout() {
mkdir -p /tmp/rom
rclone copy NFS:ccache/arcanaos/out.tar.gz /tmp/rom -P
cd /tmp/rom
time tar xf out.tar.gz
rm -rf out.tar.gz
}

function check() {
cat /etc/os*
env
nproc
gcc --version
clang --version
cd /tmp
}

rcloneccache
rclonemanifest
#rcloneout
check
