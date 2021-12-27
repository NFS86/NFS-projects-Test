#!/bin/bash
cd /tmp/rom

function setcache() {
ccache -M 8G
ccache -o compression=true
ccache -z
}

function finerr() {
    curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="================================%0A<code>Building Rom Gagal,Jiancoeg..</code>%0A================================" \
    curl -s -X POST https://api.telegram.org/$TG_TOKEN/sendSticker -d sticker=CAACAgIAAx0CXjGT1gACDRRhYsUKSwZJQFzmR6eKz2aP30iKqQACPgADr8ZRGiaKo_SrpcJQIQQ -d chat_id=$TG_CHAT_ID
    exit 1
}

function sentup() {
. build/envsetup.sh
}

function anu() {
lunch octavi_rosy-userdebug
}

function build() {
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="===========================%0A<code>Building ccache started..</code>%0A$(echo "${var_cache_report_config}")"
export CCACHE_EXEC=$(which ccache)
export WITH_GAPPS=false
brunch rosy -j24 &
sleep 95m
kill %1
ccache -s
}
setcache
sentup
anu
build