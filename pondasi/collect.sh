#!/bin/bash
cd /tmp/rom

function setcache() {
ccache -M 10G
ccache -o compression=false
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
lunch aosp_rosy-userdebug
}

function set() {
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache
cp -fpr /tmp/ccache/ccache.conf /etc/ccache.conf
export CCACHE_EXEC=$(which ccache)
}

function build() {
make VENDORIMAGES -j8 &
sleep 95m
kill %1
ccache -s
}

function push() {
cd /tmp/rom/out/target/product/rosy/system/priv-app/NFSParts
    zip -r9 NFSParts.zip *
    ZIP=$(echo *.zip)
    curl -F document=@$ZIP "https://api.telegram.org/$TG_TOKEN/sendDocument" \
        -F chat_id="$TG_CHAT_ID" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" 
}
setcache
sentup
anu
set
build
#push
