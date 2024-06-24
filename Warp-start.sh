sudo systemctl start warp-svc
warp-cli connect

function check_warp_on() {
  # Gửi yêu cầu GET đến URL và kiểm tra kết quả trả về
  result=$(curl -s https://www.cloudflare.com/cdn-cgi/trace)

  # Sử dụng grep để tìm chuỗi "warp=on" trong kết quả
  echo "$result" | grep -q "warp=on"

  # Kiểm tra mã thoát của lệnh grep
  if [ $? -eq 0 ]; then
    # Nếu mã thoát là 0, trả về true
    return 0
  else
    # Nếu mã thoát không phải là 0, trả về false
    return 1
  fi
}

if check_warp_on; then
  echo "Thành công: warp=on"
else
  echo "Thất bại: warp=off hoặc không thể kiểm tra được trạng thái warp"
fi