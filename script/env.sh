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
for t in ccache gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done   
update-ccache-symlinks
dpkg -l ccache 
echo export PATH="/usr/lib/ccache:$PATH"
which ccache gcc g++ cc c++ clang clang++
cd /tmp/cirrus-ci-build/rom && ls
