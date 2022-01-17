#!/bin/bash

cd /tmp/rom
repo init --depth=1 --no-repo-verify -u https://github.com/projectarcana-aosp/manifest -b 12.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS-projects/local_manifest --depth 1 -b arcana-12 .repo/local_manifests
repo sync -c -j8 --force-sync --no-clone-bundle --no-tags
