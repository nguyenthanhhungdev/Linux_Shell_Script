#!/bin/bash

# Hàm kiểm tra cài đặt tuned
function check_tuned_installed() {
  if ! command -v tuned-adm >/dev/null; then
    echo "Lỗi: tuned chưa được cài đặt. Vui lòng cài đặt tuned trước khi sử dụng script này."
    exit 1
  fi
}

# Hàm in thông tin hệ thống
function print_system_info() {
  echo "## Thông tin hệ thống ##"
  uname -a
  cat /proc/cpuinfo | grep -i 'model name' | uniq
  cat /proc/cpuinfo | grep -i 'cpu MHz' | uniq
  echo "Hệ điều hành: $(uname -sr)"
  echo "Kiến trúc: $(uname -m)"
}

# Hàm thiết lập chế độ "government" hiệu suất cao
function set_performance_governor() {
  echo "Thiết lập chế độ 'government' hiệu suất cao"
  sudo cpupower frequency-set -g performance
}

# Hàm thiết lập tần suất CPU
function set_cpu_frequency() {
  echo "Thiết lập tần suất CPU tối thiểu 4300 MHz"
  sudo cpupower frequency-set -d 4400 all
}

# Hàm hiển thị thông tin tần suất CPU
function show_cpu_frequency_info() {
  echo "Thông tin tần suất CPU"
  cpupower frequency-info
}

# Hàm bật và kích hoạt dịch vụ tuned
function enable_and_start_tuned() {
  echo "Bật và kích hoạt dịch vụ tuned"
  sudo systemctl enable --now tuned
}

# Hàm áp dụng cấu hình tuned cho các profile
function apply_tuned_profiles() {
  echo "Áp dụng cấu hình tuned cho các profile"
  tuned-adm profile throughput-performance virtual-host network-throughput hpc-compute throughput-performance
}

# Hàm xác nhận cấu hình tuned đang hoạt động
function confirm_tuned_active() {
  echo "Xác nhận cấu hình tuned đang hoạt động"
  sudo tuned-adm active
}

# Hàm khởi động dịch vụ fancontrol (tùy chọn)
function start_fancontrol() {
  echo "Khởi động dịch vụ fancontrol (tùy chọn)"
  sudo systemctl start fancontrol
}

# Hàm chạy fancontrol (tùy chọn)
function run_fancontrol() {
  echo "Chạy fancontrol (tùy chọn)"
  sudo fancontrol
}

#Hàm thiết lập tần suất CPU
function set_cpu_frequency_ryzenadj() {
  echo "Thiết lập công suất CPU"
  if ! command -v ryzenadj >/dev/null; then
    echo "Lỗi: ryzenadj chưa được cài đặt. Vui lòng cài đặt ryzenadj trước khi sử dụng script này."
    sudo dnf install cmake gcc-c++ pciutils-devel
    git clone https://github.com/FlyGoat/RyzenAdj.git
    cd RyzenAdj
    rm -r win32
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make
    if [ -d ~/.local/bin ]; then ln -s ryzenadj ~/.local/bin/ryzenadj && echo "symlinked to ~/.local/bin/ryzenadj"; fi
    if [ -d ~/.bin ]; then ln -s ryzenadj ~/.bin/ryzenadj && echo "symlinked to ~/.bin/ryzenadj"; fi
  fi
  sudo ./ryzenadj -i
  sudo ./ryzenadj --stapm-limit=35000 --fast-limit=35000 --slow-limit=35000 --tctl-temp=90
}

# Gọi các hàm
check_tuned_installed
print_system_info
set_performance_governor
set_cpu_frequency
show_cpu_frequency_info
enable_and_start_tuned
apply_tuned_profiles
confirm_tuned_active

# Khởi động và chạy fancontrol (tùy chọn)
start_fancontrol
run_fancontrol
