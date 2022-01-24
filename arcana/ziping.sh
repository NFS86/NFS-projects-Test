#!/bin/bash

ifeq ($(strip $(BUILD_TYPE)),systemimage)
echo Build variant SYSTEM terdeteksi..
echo Melanjutkan untuk upload ccache SYSTEM
pushcachesytem
echo upload ccache done
pushsystem
echo upload system done
endif

ifeq ($(strip $(BUILD_TYPE)),vendorimage)
echo Build variant VENDOR terdeteksi..
echo Melanjutkan untuk upload ccache VENDOR
pushcachevendor
echo upload ccache done
pushvendor
echo upload vendor done
endif

function pushcachesytem() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/arcanaos/system -P
rm -rf ccache.tar.gz
}

function pushcachevendor() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/arcanaos/vendor -P
rm -rf ccache.tar.gz
}

function pushsystem() {
cd /tmp/rom/out/target/product/rosy
zip -r9 system.zip system.img
rclone copy system.zip NFS:ccache/system -P
}

function pushvendor() {
cd /tmp/rom/out/target/product/rosy
rclone copy vendor.img NFS:ccache/arcanaos/vendor -P
}

function dono() {
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Build and upload done ✅"
}

dono
