#!/bin/bash

declare -a service_list
declare -i index

get_all_service() {
#  sudo systemctl list-units --type=service --state=running
  IFS=$'\n' service_list=( $(systemctl list-units --type=service --state=running | awk '/.service/ {print $1}') )

  echo "STT|    Tên service"
  for i in "${!service_list[@]}"; do
    echo "$((i+1))|    ${service_list[$i]}"
  done
}

get_service_by_number() {
  index=$1

  if ! [[ "$index" =~ ^[0-9]+$ ]] || [ "$index" -le 0 ] || [ "$index" -gt "${#service_list[@]}" ]; then
    echo "Số thứ tự không hợp lệ. Thoát chương trình."
    exit 1
  fi

  if [ ${#service_list[@]} -eq 0 ] ; then
    echo "Không tìm thấy service"
    exit 1
  fi

  service_name=$(echo "${service_list[$((index-1))]}" | awk '{print $1}' | sed 's/^ *//;s/ *$//');
  echo "$service_name";
}

search_service() {
#  sudo systemctl list-units --type=service --state=running | grep $1
  IFS=$'\n' service_list2=( $(sudo systemctl list-units --type=service --state=running | grep $1) )

  echo "Danh sách service:"
  for i in "${!service_list2[@]}"; do
    echo "$((i+1))|    ${service_list2[$i]}"
  done

  echo "Nhập số thứ tự của service muốn chọn:"
  read index2

  if ! [[ "$index2" =~ ^[0-9]+$ ]] || [ "$index2" -le 0 ] || [ "$index2" -gt "${#service_list2[@]}" ]; then
    echo "Số thứ tự không hợp lệ. Thoát chương trình."
    exit 1
  fi

  if [ ${#service_list2[@]} -eq 0 ] ; then
    echo "Không tìm thấy service"
    exit 1
  fi

  service_name=$(echo "${service_list2[$((index2-1))]}" | awk '{print $1}')
  echo "Service name: $service_name"

  echo "1. Get all service"
  echo "2. Start service"
  echo "3. Stop service"
  echo "4. Restart service"
  echo "5. Enable service"
  echo "6. Disable service"
  echo "7. Reload service"
  echo "8. Status service"
  echo "9. Exit"
  read -p -r "Enter your choice: " choice
  case $choice in
    1) start_service "$service_name" ;;
    2) stop_service "$service_name" ;;
    3) restart_service "$service_name" ;;
    4) enable_service "$service_name" ;;
    5) disable_service "$service_name" ;;
    6) reload_service "$service_name" ;;
    7) status_service "$service_name" ;;
    8) exit ;;
    *) echo "Invalid choice" ;;
  esac
}

# Hàm kiểm tra một câu lệnh có thực thi thành công hay không
check_command_success() {
  if [ $? -eq 0 ]; then
    echo "Command executed successfully."
  else
    echo "Command execution failed."
  fi
}

# Hàm start service
start_service() {
  sudo systemctl start "$1"
}

# Hàm stop service
stop_service() {
  echo "Stop service: $1"

  # Thực hiện stop service và kiểm tra kết quả
  sudo systemctl stop "$1"

  check_command_success
}

# Hàm restart service
restart_service() {
  sudo systemctl restart "$1"
}

# Hàm enable service
enable_service() {
  sudo systemctl enable "$1"
}

# Hàm disable service
disable_service() {
  sudo systemctl disable "$1"
}

# Hàm reload service
reload_service() {
  sudo systemctl reload "$1"
}

# Hàm status service
status_service() {
  sudo systemctl status "$1"
}

menu() {
  echo "Danh sách service:"
  get_all_service

  echo "Chọn chức năng:"
  echo "1. Start service"
  echo "2. Stop service"
  echo "3. Restart service"
  echo "4. Enable service"
  echo "5. Disable service"
  echo "6. Reload service"
  echo "7. Status service"
  echo "8. Search service"
  echo "9. Exit"
  read -p "Enter your choice: " choice
  case $choice in
    1) read -p "Enter service name: " service_name; start_service  "$service_name";;
    2) read -p "Enter service number: " service_number;
      stop_service  "$(get_service_by_number "$service_number")"
      read -p "Enter to back menu"
      ;;
    9) exit ;;
    *) echo "Invalid choice" ;;
  esac
}

main() {
  while true; do
    menu
  done
}

main


