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
  search_term=$1
  IFS=$'\n' service_list2=( $(systemctl list-units --type=service --all | grep -i "$search_term") )

  if [ ${#service_list2[@]} -eq 0 ] ; then
    echo "Không tìm thấy service"
  else
    echo "Danh sách service:"
    for i in "${!service_list2[@]}"; do
      echo "$((i+1))|    ${service_list2[$i]}"
    done
  fi

  check_command_success
#  service_name=$(echo "${service_list2[$((index2-1))]}" | awk '{print $1}')
#  echo "Service name: $service_name"
}

# Hàm kiểm tra một câu lệnh có thực thi thành công hay không
check_command_success() {
  if [ $? -eq 0 ]; then
    echo "Command executed successfully."
  else
    echo "Command execution failed."
  fi
  read -p "Enter to back menu"
}

# Hàm start service
start_service() {
  sudo systemctl start "$1"

#  read -p "Enter to back menu"
  check_command_success
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

  check_command_success
}

# Hàm enable service
enable_service() {
  sudo systemctl enable "$1"

  check_command_success
}

# Hàm disable service
disable_service() {
  sudo systemctl disable "$1"

  check_command_success
}

# Hàm reload service
reload_service() {
  sudo systemctl reload "$1"

  check_command_success
}

# Hàm status service
status_service() {
  sudo systemctl status "$1"
}

menu() {
  echo "=========================================="
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
      ;;
    3) read -p "Enter service number: " service_number;
      restart_service  "$(get_service_by_number "$service_number")"
      ;;
    4) read -p "Enter service number: " service_number;
      enable_service  "$(get_service_by_number "$service_number")"
      ;;
    5) read -p "Enter service number: " service_number;
      disable_service  "$(get_service_by_number "$service_number")"
      ;;
    6) read -p "Enter service number: " service_number;
      reload_service  "$(get_service_by_number "$service_number")"
      ;;
    7) read -p "Enter service number: " service_number;
      status_service  "$(get_service_by_number "$service_number")"
      ;;
    8) read -p "Enter search term: " search_term;
      search_service "$search_term"
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


