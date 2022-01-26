#!/bin/bash

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
cd /tmp/rom
repo init --depth=1 --no-repo-verify -u $SYNC -g default,-mips,-darwin,-notdefault
git clone $LOCAL_MANIFEST --depth 1 .repo/local_manifests
repo sync -j8 -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
