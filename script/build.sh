#!/bin/bash
cd /tmp/cirrus-ci-build/rom

function check() {
if ! [ -a "$SYSTEM_IMAGE" ]; then
	checkv
fi
}

function checkv() {
if ! [ -a "$VENDOR_IMAGE" ]; then
	checkb
fi
}

function checkb() {
if ! [ -a "$BOOT_IMAGE" ]; then
	finerr
	exit 1
fi
}

function finerr() {
    curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="================================%0A<code>Building Gagal,Jiancoeg..</code>%0A================================" \
    curl -s -X POST https://api.telegram.org/$TG_TOKEN/sendSticker -d sticker=CAACAgIAAx0CXjGT1gACDRRhYsUKSwZJQFzmR6eKz2aP30iKqQACPgADr8ZRGiaKo_SrpcJQIQQ -d chat_id=$TG_CHAT_ID
    exit 1
}

function pushout() {
cd /tmp/cirrus-ci-build/rom/out/target/product
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com rosy 1
rclone copy rosy.tar.gz NFS:ccache/$DIR -P
rm -rf rosy.tar.gz
}

if [ "$BUILD_CCACHE_ONLY" == "true" ]; then
  ccache -M 50G
  export CCACHE_EXEC=$(which ccache)
  export USE_CCACHE=1
  export CCACHE_COMPRESS=true
  export CCACHE_COMPRESSLEVEL=1
  export CCACHE_LIMIT_MULTIPLE=0.9
  export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
  export CCACHE_CONFIGPATH=/tmp/cirrus-ci-build/ccache/ccache.conf
  ccache -o compression=true
  ccache - a fast C/C++ compiler cache
  ccache -z
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j23 &
  if [ "$BUILD_OUT_FOLDER" == "yes" ]; then
     echo BUILD OUT FOLDER AKTIF..
     sleep 80m
     kill %1
     pushout
     ccache -s
     exit 1
  fi
  sleep 95m
  kill %1
  ccache -s
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
  ccache -M 50G
  export CCACHE_EXEC=$(which ccache)
  export USE_CCACHE=1
  export CCACHE_COMPRESS=true
  export CCACHE_COMPRESSLEVEL=1
  export CCACHE_LIMIT_MULTIPLE=0.9
  export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
  export CCACHE_CONFIGPATH=/tmp/cirrus-ci-build/ccache/ccache.conf
  ccache -o compression=true
  ccache - a fast C/C++ compiler cache
  ccache -z
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j23
  check
  ccache -s
fi
