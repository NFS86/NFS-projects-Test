#!/bin/bash
cd /tmp/rom

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

if [ "$BUILD_CCACHE_ONLY" == "true" ]; then
  ccache -M 20G
  export USE_CCACHE=1
  export CCACHE_DIR=/tmp/ccache
  export CCACHE_EXEC=$(which ccache)
  export CCACHE_CONFIGPATH=/tmp/ccache/ccache.conf
  ccache -o compression=true
  ccache - a fast C/C++ compiler cache
  for t in ccache gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done
  ccache -z
  cp -r /tmp/ccache/ccache.conf /etc/ccache.conf
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j25 &
  sleep 95m
  kill %1
  ccache -s
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
  ccache -M 20G
  export USE_CCACHE=1
  export CCACHE_DIR=/tmp/ccache
  export CCACHE_EXEC=$(which ccache)
  export CCACHE_CONFIGPATH=/tmp/ccache/ccache.conf
  ccache -o compression=true
  ccache - a fast C/C++ compiler cache
  for t in ccache gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done
  ccache -z
  cp -r /tmp/ccache/ccache.conf /etc/ccache.conf
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j25
  ccache -s
fi

#check
