#!/bin/bash

cd /tmp

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com ccache 1
rclone copy ccache.tar.gz anggitjav:ccache/rom -P
rm -rf rom.tar.gz 
time com rom 1
rclone copy rom.tar.gz anggitjav:Spark -P
rm -rf rom.tar.gz
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Build ccache done...."
