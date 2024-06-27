#!/bin/bash

# Lấy danh sách các kernel
kernels=( $(rpm -qa kernel) )

# Hiển thị danh sách các kernel
echo "số thứ tự        tên kernel"
for i in "${!kernels[@]}"; do
  echo "$((i+1))        ${kernels[$i]}"
done

# Nhận số thứ tự từ người dùng
echo "Nhập số thứ tự của kernel muốn xóa:"
read index

# Kiểm tra xem số thứ tự có hợp lệ không
if [ "$index" -le 0 ] || [ "$index" -gt "${#kernels[@]}" ]; then
  echo "Số thứ tự không hợp lệ. Thoát chương trình."
  exit 1
fi

# Xóa kernel
sudo dnf remove "${kernels[$((index-1))]}"