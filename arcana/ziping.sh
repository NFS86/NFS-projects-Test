#!/bin/bash

function pushcachesytem() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/$DIR/system -P
rm -rf ccache.tar.gz
}

function pushcachevendor() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/$DIR/vendor -P
rm -rf ccache.tar.gz
}

function pushcacheboot() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/$DIR/boot -P
rm -rf ccache.tar.gz
}

function pushcachefull() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/$DIR/full -P
rm -rf ccache.tar.gz
}

function pushsystem() {
cd /tmp/rom/out/target/product/rosy
zip -r9 system.zip system.img
rclone copy system.zip NFS:ccache/$DIR/system -P
}

function pushvendor() {
cd /tmp/rom/out/target/product/rosy
rclone copy vendor.img NFS:ccache/$DIR/vendor -P
}

function pushboot() {
cd /tmp/rom/out/target/product/rosy
rclone copy boot.img NFS:ccache/$DIR/boot -P
}

function dono() {
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Build and upload done ✅"
}


if [ "$BUILD_CCACHE_ONLY" == "true" ]; then
   if [ "$BUILD_SYSTEM_ONLY" == "true" ]; then
      echo Build variant SYSTEM terdeteksi..
      echo Melanjutkan untuk upload ccache SYSTEM
      pushcachesytem
      echo upload ccache done
   fi
   if [ "$BUILD_VENDOR_ONLY" == "true" ]; then
      echo Build variant VENDOR terdeteksi..
      echo Melanjutkan untuk upload ccache VENDOR
      pushcachevendor
      echo upload ccache done
   fi
   if [ "$BUILD_BOOT_ONLY" == "true" ]; then
      echo Build variant Boot terdeteksi..
      echo Melanjutkan untuk upload ccache BOOT
      pushcacheboot
      echo upload ccache done
   fi
   if [ "$BUILD_FULL" == "true" ]; then
      echo Build variant Full terdeteksi..
      echo Melanjutkan untuk upload ccache Full
      pushcachefull
      echo upload ccache done
   fi
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
   if [ "$BUILD_SYSTEM_ONLY" == "true" ]; then
      echo Build variant SYSTEM terdeteksi..
      echo Melanjutkan untuk upload ccache SYSTEM
      pushcachesytem
      echo upload ccache done
      pushsystem
      echo upload system done
   fi
   if [ "$BUILD_VENDOR_ONLY" == "true" ]; then
      echo Build variant VENDOR terdeteksi..
      echo Melanjutkan untuk upload ccache VENDOR
      pushcachevendor
      echo upload ccache done
      pushvendor
      echo upload vendor done
   fi
   if [ "$BUILD_BOOT_ONLY" == "true" ]; then
      echo Build variant Boot terdeteksi..
      echo Melanjutkan untuk upload ccache BOOT
      pushcacheboot
      echo upload ccache done
      pushboot
      echo upload vendor done
   fi
fi

dono
