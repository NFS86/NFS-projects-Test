#!/bin/bash

rclone copy /tmp/rom/out/target/product/rosy/ProjectArcana*.zip anggitjav:rosy -P
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d "disable_web_page_preview=true" -d "parse_mode=html" -d text=Build $(cd /tmp/rom/out/target/product/rosy/ && ls ProjectArcana*.zip) Completed!%0ADownload link : https://nfs.jarbull86.workers.dev/rosy/$(cd /tmp/rom/out/target/product/rosy/ && ls ProjectArcana*.zip)
curl -s -X POST https://api.telegram.org/$TG_TOKEN/sendSticker -d sticker=CAACAgIAAx0CXjGT1gACAeVg69gXIw-a6h1nvmmaub51tQQwCgACLQMAAsbMYwIquW4nbs0crSAE -d chat_id=$TG_CHAT_ID
