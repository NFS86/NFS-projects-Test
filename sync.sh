#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b snow -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/NFS-projects/local_manifest -b evolution-12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
