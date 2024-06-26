#!/bin/bash

# Lấy danh sách các DE
IFS=$'\n' de_list=( $(sudo dnf grouplist -v | grep "Desktop") )

# Hiển thị danh sách các DE
echo "số thứ tự|    tên DE"
for i in "${!de_list[@]}"; do
  echo "$((i+1))|    ${de_list[$i]}"
done

# Nhận số thứ tự từ người dùng
echo "Nhập số thứ tự của DE muốn cài đặt:"
read index

# Kiểm tra xem số thứ tự có hợp lệ không
if ! [[ "$index" =~ ^[0-9]+$ ]] || [ "$index" -le 0 ] || [ "$index" -gt "${#de_list[@]}" ]; then
  echo "Số thứ tự không hợp lệ. Thoát chương trình."
  exit 1
fi

# Cài đặt DE
de_name=$(echo "${de_list[$((index-1))]}" | cut -d'(' -f1)
de_name_trimmed=$(echo "$de_name" | sed 's/^ *//;s/ *$//')
echo "Cài đặt $de_name_trimmed"
sudo dnf group install "$de_name_trimmed"