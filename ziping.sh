#!/bin/bash

function pushcache() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/vendor -P
rm -rf ccache.tar.gz
}

function pushout() {
cd /tmp/rom
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com out 1
rclone copy out.tar.gz NFS:ccache/arcanaos -P
rm -rf out.tar.gz
}

function pushrom() {
cd /tmp
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com rom 1
rclone copy rom.tar.gz NFS:ccache/arcanaos -P
rm -rf rom.tar.gz
}

function dono() {
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Build vendor and upload ccache [✅]%0Avendor link: https://needforspeed.projek.workers.dev/ccache/vendor/vendor.img"
rm -rf /tmp/*
}

pushcache
#pushout
#pushrom
dono
