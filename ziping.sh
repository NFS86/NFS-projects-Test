#!/bin/bash

cd /tmp

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com ccache 1
rclone copy ccache.tar.gz NFS:ccache/rom -P
rm -rf ccache.tar.gz

cd /tmp/rom

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com out 1
rclone copy out.tar.gz NFS:ccache/rom -P
rm -rf out.tar.gz

curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Build ccache done...."
