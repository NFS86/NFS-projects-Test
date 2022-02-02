#!/bin/bash

cd /tmp/cirrus-ci-build
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf
mkdir -p /tmp/cirrus-ci-build/ccache
rclone copy NFS:ccache/$DIR/ccache.tar.gz /tmp/cirrus-ci-build -P
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz
cat /etc/os*
env
nproc
gcc --version
clang --version
cat > /etc/ccache.conf <<EOF
compression = true
EOF
cd /tmp/cirrus-ci-build/rom && ls
