#!/bin/bash

name_rom=$(grep init $CIRRUS_WORKING_DIR/sync.sh -m 1 | cut -d / -f 4)
cd $CIRRUS_WORKING_DIR/rom/$name_rom
export ALLOW_MISSING_DEPENDENCIES=true
export CCACHE_DIR=/home/cirrus-ci-build/ccache
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
  $BUILD_TYPE -j18 &
  sleep 95m
  kill %1
  ccache -s
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
  . build/envsetup.sh
  lunch $LUNCH
  $BUILD_TYPE -j18
  ccache -s
fi
