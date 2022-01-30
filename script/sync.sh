#!/bin/bash

cd /tmp/cirrus-ci-build/rom
repo init --depth=1 --no-repo-verify -u $SYNC -g default,-mips,-darwin,-notdefault
git clone $LOCAL_MANIFEST --depth 1 .repo/local_manifests
repo sync -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j8
