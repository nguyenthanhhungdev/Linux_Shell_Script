#!/bin/bash

# Lấy liên kết tải xuống mới nhất
latest_url=$(curl -s https://www.jetbrains.com/toolbox-app/ | grep -oP 'https://download\.jetbrains\.com/toolbox/jetbrains-toolbox-[0-9.]+\.tar\.gz' | head -n 1)

# Tải xuống và giải nén
wget "$latest_url"
tar -xzf jetbrains-toolbox-*.tar.gz -C ~/
#
## Chạy JetBrains Toolbox
#./jetbrains-toolbox-*
