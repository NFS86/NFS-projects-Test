#!/bin/bash
cd /tmp/rom

function setcache() {
ccache -M 50G
ccache -o compression=true
ccache -z
}

function finerr() {
    curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="================================%0A<code>Building vendor Gagal,Jiancoeg..</code>%0A================================" \
    curl -s -X POST https://api.telegram.org/$TG_TOKEN/sendSticker -d sticker=CAACAgIAAx0CXjGT1gACDRRhYsUKSwZJQFzmR6eKz2aP30iKqQACPgADr8ZRGiaKo_SrpcJQIQQ -d chat_id=$TG_CHAT_ID
    exit 1
}

function sentup() {
. build/envsetup.sh
}

function anu() {
lunch aosp_rosy-userdebug
}

function setdolo() {
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache
cp -fpr /tmp/ccache/ccache.conf /etc/ccache.conf
export CCACHE_EXEC=$(which ccache)
}

function build() {
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="================================%0A<code>Test Building vendor image..</code>%0A$(echo "${var_cache_report_config}")"
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="================================%0A<b>Show build: </b>https://cirrus-ci.com/github/NFS86/NFS-projects-Test/vendor%0A================================"
make systemimage -j8 &
sleep 90m
kill %1
ccache -s
}

function check() {
if ! [ -a "$VENDOR" ]; then
	finerr
	exit 1
fi
}

function push() {
cd /tmp/rom/out/target/product/rosy
    rclone copy vendor.img NFS:ccache/vendor -P
}
setcache
sentup
anu
setdolo
build
#check
#push
