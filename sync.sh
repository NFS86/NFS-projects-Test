#!/bin/bash

cd /tmp/rom
repo init --depth=1 --no-repo-verify -u https://github.com/Octavi-OS/platform_manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS86/local_manifest --depth 1 -b oct-12 .repo/local_manifests
repo sync -c -j8 --force-sync --no-clone-bundle --no-tags
