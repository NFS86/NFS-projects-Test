#!/bin/bash

cd /home/cirrus-ci-build
mkdir -p ~/.config/rclone
mkdir -p rom
mkdir -p ccache
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf
mkdir -p /home/cirrus-ci-build/ccache
rclone copy NFS:ccache/$DIR/ccache.tar.gz /home/cirrus-ci-build -P
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
cd /home/cirrus-ci-build/rom && ls
