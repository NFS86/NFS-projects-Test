#!/bin/bash

export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
export CCACHE_CONFIGPATH=/tmp/cirrus-ci-build/ccache/ccache.conf
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_COMPRESS=true
export CCACHE_COMPRESSLEVEL=1
export CCACHE_LIMIT_MULTIPLE=0.9
ccache -M 50G
ccache -F 999999999
ccache -o compression=true
ccache - a fast C/C++ compiler cache
for t in ccache gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done
ccache -z
ccache -p
