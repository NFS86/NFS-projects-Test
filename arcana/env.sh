#!/bin/bash

cd /tmp/cirrus-ci-build
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf

if [ "$BUILD_SYSTEM_ONLY" == "true" ]; then
  echo Build variant SYSTEM terdeteksi..
  echo Melanjutkan untuk mengambil ccache SYSTEM
  mkdir -p /tmp/cirrus-ci-build/ccache
  rclone copy NFS:ccache/$DIR/system/ccache.tar.gz /tmp/cirrus-ci-build -P
  time tar xf ccache.tar.gz
  rm -rf ccache.tar.gz
fi

if [ "$BUILD_VENDOR_ONLY" == "true" ]; then
  echo Build variant VENDOR terdeteksi..
  echo Melanjutkan untuk mengambil ccache VENDOR
  mkdir -p /tmp/cirrus-ci-build/ccache
  rclone copy NFS:ccache/$DIR/vendor/ccache.tar.gz /tmp/cirrus-ci-build -P
  time tar xf ccache.tar.gz
  rm -rf ccache.tar.gz
fi

if [ "$BUILD_BOOT_ONLY" == "true" ]; then
  echo Build variant Boot terdeteksi..
  echo Melanjutkan untuk mengambil ccache Boot
  mkdir -p /tmp/cirrus-ci-build/ccache
  rclone copy NFS:ccache/$DIR/boot/ccache.tar.gz /tmp/cirrus-ci-build -P
  time tar xf ccache.tar.gz
  rm -rf ccache.tar.gz
fi

if [ "$BUILD_FULL" == "true" ]; then
  echo Build variant Full terdeteksi..
  echo Melanjutkan untuk mengambil ccache Full
  mkdir -p /tmp/cirrus-ci-build/ccache
  rclone copy NFS:ccache/$DIR/full/ccache.tar.gz /tmp/cirrus-ci-build -P
  time tar xf ccache.tar.gz
  rm -rf ccache.tar.gz
fi

function check() {
cat /etc/os*
env
nproc
gcc --version
clang --version
cd /tmp/cirrus-ci-build
}

check
