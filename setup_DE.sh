#!/bin/bash

# Lấy danh sách các DE
de_list=( $(sudo dnf grouplist -v | grep "Desktop") )

# Hiển thị danh sách các DE
echo "số thứ tự|    tên DE"
for i in "${!de_list[@]}"; do
  echo "$((i+1))|    ${de_list[$i]}"
done

# Nhận số thứ tự từ người dùng
echo "Nhập số thứ tự của DE muốn cài đặt:"
read index

# Kiểm tra xem số thứ tự có hợp lệ không
if [ "$index" -le 0 ] || [ "$index" -gt "${#de_list[@]}" ]; then
  echo "Số thứ tự không hợp lệ. Thoát chương trình."
  exit 1
fi

# Cài đặt DE
sudo dnf group install "${de_list[$((index-1))]}"