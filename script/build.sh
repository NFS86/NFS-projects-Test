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

function caceng() {
export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
export CCACHE_CONFIGPATH=/tmp/cirrus-ci-build/ccache/ccache.conf
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_COMPRESS=true
export CCACHE_COMPRESSLEVEL=5
export CCACHE_LIMIT_MULTIPLE=1
ccache -M 50G
ccache -F 999999999
ccache -o compression=true
ccache - a fast C/C++ compiler cache
for t in ccache gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done
ccache -z
}

if [ "$BUILD_CCACHE_ONLY" == "true" ]; then
  caceng
  . build/envsetup.sh
  lunch $LUNCH
  if [ "$BUILD_OUT_FOLDER" == "yes" ]; then
     echo BUILD OUT FOLDER AKTIF..
     $BUILD_TYPE -j23 &
     sleep 30m
     kill %1
     ccache -x && ccache -s
     pushout
     exit 1
  fi
  $BUILD_TYPE -j23 &
  sleep 95m
  kill %1
  ccache -x && ccache -s
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
  caceng
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j23
  ccache -x && ccache -s
  check
fi
