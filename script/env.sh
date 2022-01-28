#!/bin/bash

cd /tmp/cirrus-ci-build
mkdir -p ~/.config/rclone
echo "$rcloneconfig" > ~/.config/rclone/rclone.conf

function check() {
cat /etc/os*
env
nproc
gcc --version
clang --version
cat > /tmp/cirrus-ci-build/ccache/ccache.conf <<EOF
max_size = 50.0G
compression = true
compression_level = 1
limit_multiple = 0.9
EOF
cd /tmp/cirrus-ci-build
}

if [ "$BUILD_OUT_FOLDER" == "yes" ]; then
   echo use out folder terdeteksi..
   mkdir -p /tmp/cirrus-ci-build/rom/out/target/product
   rclone copy NFS:ccache/$DIR/rosy.tar.gz /tmp/cirrus-ci-build/rom/out/target/product -P
   cd /tmp/cirrus-ci-build/rom/out/target/product
   time tar xf rosy.tar.gz
   rm -rf rosy.tar.gz
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
fi

if [ "$BUILD_OUT_FOLDER" == "no" ]; then
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
fi

check
