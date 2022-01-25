#!/bin/bash

ccache -M 20G
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
ccache -o compression=true
ccache - a fast C/C++ compiler cache
for t in ccache gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done
ccache -z
