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
ccache -c && ccache -z

if [ "$BUILD_CCACHE_ONLY" == "true" ]; then
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j8 &
  sleep 95m
  kill %1
  ccache -x && ccache -s
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j8
  ccache -x && ccache -s
fi
