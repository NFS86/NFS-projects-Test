#!/bin/bash
cd /tmp/cirrus-ci-build/rom

export ALLOW_MISSING_DEPENDENCIES=true
export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_COMPRESS=true
ccache -M 0
ccache -F 0
ccache - a fast C/C++ compiler cache
for t in ccache gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done   
ccache -z

if [ "$BUILD_CCACHE_ONLY" == "true" ]; then
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j10 &
  sleep 95m
  kill %1
  ccache -x && ccache -s
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j10
  ccache -x && ccache -s
fi
