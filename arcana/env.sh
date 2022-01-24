#!/bin/bash

cd /tmp
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf

ifneq ($(BUILD_TYPE),systemimage)
echo Build variant SYSTEM terdeteksi..
echo Melanjutkan untuk mengambil ccache SYSTEM
mkdir -p /tmp/ccache
rclone copy NFS:ccache/arcanaos/system/ccache.tar.gz /tmp -P
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz
endif

ifneq ($(BUILD_TYPE),vendorimage)
echo Build variant VENDOR terdeteksi..
echo Melanjutkan untuk mengambil ccache VENDOR
mkdir -p /tmp/ccache
rclone copy NFS:ccache/arcanaos/vendor/ccache.tar.gz /tmp -P
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz
endif

function check() {
cat /etc/os*
env
nproc
gcc --version
clang --version
cd /tmp
}

check
