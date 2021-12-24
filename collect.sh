#!/bin/bash
cd /tmp/rom

. build/envsetup.sh
lunch spark_rosy-userdebug
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 20G
ccache -o compression=true
ccache -z
mka bacon -j8 &
sleep 90m
kill %1
ccache -s
