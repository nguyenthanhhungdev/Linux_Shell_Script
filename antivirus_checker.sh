function update() {
sudo freshclam
}

function scan_directory() {
  local directory=$1
  if [ -d "$directory" ]; then
    clamscan -r --infected --no-summary "$directory" | while read -r line; do
      file=$(echo "$line" | awk '{print $2}')
      echo "Virus detected in file: $file"
    done
  else
    echo "Directory does not exist."
  fi
}
function scan_file() {
  local file=$1
  if [ -f "$file" ]; then
    clamscan "$file"
  else
    echo "File does not exist."
  fi
}

#Phút (0-59)
#Giờ (0-23)
#Ngày trong tháng (1-31)
#Tháng (1-12)
#Ngày trong tuần (0-7, với 0 và 7 đều đại diện cho Chủ Nhật)

function schedule_scan() {
  local directory=$1
  local schedule=$2
  (crontab -l 2>/dev/null; echo "$schedule clamscan -r $directory") | crontab -
}

while true; do
  echo "1. Scan a directory"
  echo "2. Scan a file"
  echo "3. Update"
  echo "4. Schedule a scan"
  echo "5. Exit"
  read -p "Choose an option: " option

  case $option in
    1)
      read -p "Enter the directory to scan: " directory
      scan_directory "$directory"
      ;;
    2)
      read -p "Enter the file to scan: " file
      scan_file "$file"
      ;;
    3)
      update
      ;;
    4)
      read -p "Enter the directory to scan: " directory
      echo "
      Phút (0-59)
      Giờ (0-23)
      Ngày trong tháng (1-31)
      Tháng (1-12)
      Ngày trong tuần (0-7, với 0 và 7 đều đại diện cho Chủ Nhật)
      Ví dụ: 0 2 * * * chạy vào 2h sáng mỗi ngày
      "
      read -p "Enter the schedule: " schedule
      schedule_scan "$directory" "$schedule"
      ;;
    5)
      break
      ;;
    *)
      echo "Invalid option"
      ;;
  esac
done
