#!/bin/bash

cd /tmp/cirrus-ci-build
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/$DIR -P
rm -rf ccache.tar.gz
