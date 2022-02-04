#!/bin/bash

if [ "$BUILD_CCACHE_ONLY" == "true" ]; then
   cd /tmp/cirrus-ci-build
   com ()
   {
       tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
   }
   time com ccache 1
   rclone copy ccache.tar.gz NFS:ccache/$DIR -P
   rm -rf ccache.tar.gz
fi

if [ "$BUILD_CCACHE_ONLY" == "false" ]; then
   rclone copy /tmp/cirrus-ci-build/out/target/product/$device/$rom_name*.zip NFS:rom/$DIR -P
fi
