#!/bin/bash

cd /tmp/rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS86/local_manifest --depth 1 -b PE_12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
