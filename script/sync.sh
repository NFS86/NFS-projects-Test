#!/bin/bash

cd /tmp/cirrus-ci-build/rom
repo init -q --no-repo-verify --depth=1 -u $SYNC -g default,-device,-mips,-darwin,-notdefault
git clone $LOCAL_MANIFEST --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
