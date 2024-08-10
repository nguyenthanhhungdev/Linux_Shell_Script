#!/bin/bash


echo "Thiết lập tần suất CPU tối thiểu 400 MHz"
sudo cpupower frequency-set -d 400 all

echo "Thiết lập chế độ 'powersave' tiết kiệm năng lượng"
sudo cpupower frequency-set -g powersave


echo "Hiển thị thông tin tần suất CPU"
cpupower frequency-info

echo "Tắt và vô hiệu hóa dịch vụ tuned"
sudo systemctl stop tuned

echo "Turn off fan control"
sudo systemctl stop fancontrol
sudo systemctl status fancontrol

