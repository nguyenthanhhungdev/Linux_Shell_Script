#!/bin/bash
# Khai báo biến toàn cục
declare -a de_list
declare -i index


# Hàm hiển thị danh sách DE và nhận số thứ tự từ người dùng
get_de_index() {
  # Lấy danh sách các DE
  IFS=$'\n' de_list=( $(sudo dnf grouplist -v | grep "Desktop") )

  # Hiển thị danh sách các DE
  echo "số thứ tự|    tên DE"
  for i in "${!de_list[@]}"; do
    echo "$((i+1))|    ${de_list[$i]}"
  done

  # Nhận số thứ tự từ người dùng
  echo "Nhập số thứ tự của DE muốn chọn:"
  read index

  # Kiểm tra xem số thứ tự có hợp lệ không
  if ! [[ "$index" =~ ^[0-9]+$ ]] || [ "$index" -le 0 ] || [ "$index" -gt "${#de_list[@]}" ]; then
    echo "Số thứ tự không hợp lệ. Thoát chương trình."
    exit 1
  fi

  echo "$index"
}

# Hàm cài đặt DE
install_de() {
  if [ ${#de_list[@]} -eq 0 ] || [ $index -le 0 ] || [ $index -gt ${#de_list[@]} ]; then
    echo "Invalid index or empty array. Exiting."
    exit 1
  fi
  de_name=$(echo "${de_list[$((index-1))]}" | cut -d'(' -f1)
  de_name_trimmed=$(echo "$de_name" | sed 's/^ *//;s/ *$//')
  echo "Cài đặt $de_name_trimmed"
  sudo dnf group install "$de_name_trimmed"
}

# Hàm xóa DE
remove_de() {
  if [ ${#de_list[@]} -eq 0 ] || [ $index -le 0 ] || [ $index -gt ${#de_list[@]} ]; then
    echo "Invalid index or empty array. Exiting."
    exit 1
  fi
  de_name=$(echo "${de_list[$((index-1))]}" | cut -d'(' -f1)
  de_name_trimmed=$(echo "$de_name" | sed 's/^ *//;s/ *$//')
  echo "Xóa $de_name_trimmed"
  sudo systemctl disable lightdm
  sudo systemctl enable gdm
  sudo dnf remove "@$de_name_trimmed"
  echo " Sau khi xóa thì còn các app còn lại thì thực hiện sudo list installed
        để thực hiện xóa các app còn lại"
}
#Hàm Hiển thị menu chọn
menu() {
  echo "Chọn chức năng:"
  echo "1|      Xóa"
  echo "2|      Cài Đặt"
  read user_input

  # Kiểm tra xem số thứ tự có hợp lệ không
  if ! [[ "$user_input" =~ ^[0-9]+$ ]] || [ "$user_input" -le 0 ] || [ "$user_input" -gt 2 ]; then
    echo "Số thứ tự không hợp lệ. Thoát chương trình."
    exit 1
  fi

  get_de_index
  if [ "$user_input" -eq 1 ]; then
      remove_de
    elif [ "$user_input" -eq 2 ]; then
      install_de
    fi
}

main() {
  menu
}

main

