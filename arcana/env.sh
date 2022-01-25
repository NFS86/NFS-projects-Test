#!/bin/bash

cd /tmp
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf

if [ "$BUILD_SYSTEM_ONLY" == "true" ]; then
  echo Build variant SYSTEM terdeteksi..
  echo Melanjutkan untuk mengambil ccache SYSTEM
  mkdir -p /tmp/ccache
  rclone copy NFS:ccache/$DIR/system/ccache.tar.gz /tmp -P
  time tar xf ccache.tar.gz
  rm -rf ccache.tar.gz
fi

if [ "$BUILD_VENDOR_ONLY" == "true" ]; then
  echo Build variant VENDOR terdeteksi..
  echo Melanjutkan untuk mengambil ccache VENDOR
  mkdir -p /tmp/ccache
  rclone copy NFS:ccache/$DIR/vendor/ccache.tar.gz /tmp -P
  time tar xf ccache.tar.gz
  rm -rf ccache.tar.gz
fi

if [ "$BUILD_BOOT_ONLY" == "true" ]; then
  echo Build variant Boot terdeteksi..
  echo Melanjutkan untuk mengambil ccache Boot
  mkdir -p /tmp/ccache
  rclone copy NFS:ccache/$DIR/boot/ccache.tar.gz /tmp -P
  time tar xf ccache.tar.gz
  rm -rf ccache.tar.gz
fi

function check() {
cat /etc/os*
env
nproc
gcc --version
clang --version
cd /tmp
}

function setcache() {
ccache -M 20G
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
ccache -o compression=true
ccache - a fast C/C++ compiler cache
cp -r /tmp/ccache /usr/local/bin/
ln -s /tmp/ccache /usr/local/bin/gcc
ln -s /tmp/ccache /usr/local/bin/g++
ln -s /tmp/ccache /usr/local/bin/cc
ln -s /tmp/ccache /usr/local/bin/c++
ccache -z
}

check
setcache
