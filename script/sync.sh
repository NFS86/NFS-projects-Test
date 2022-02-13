#!/bin/bash

cd /home/cirrus-ci-build/rom
repo init --depth=1 --no-repo-verify -u $SYNC -g default,-mips,-darwin,-notdefault
git clone $LOCAL_MANIFEST --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j4
