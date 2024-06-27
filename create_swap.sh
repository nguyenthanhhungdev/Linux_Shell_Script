#!/bin/bash

# Nhận đầu vào là dung lượng swap
SWAP_SIZE=$1

# Tất cả các hàm từ `Setting_new.sh` ở đây
# ...

# Hàm tạo file swap
create_swap() {
    # Tạo một file swap với kích thước được chỉ định
    sudo fallocate -l "$SWAP_SIZE" /swapfile

    # Đặt quyền truy cập chỉ cho root
    sudo chmod 600 /swapfile

    # Đặt file này như là swap
    sudo mkswap /swapfile

    # Kích hoạt file swap
    sudo swapon /swapfile

    # Thêm file swap vào /etc/fstab để tồn tại sau khi khởi động lại
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
}

# Gọi tất cả các hàm
# ...

# Tạo file swap
create_swap