#!/bin/bash

# Đọc danh sách ID của các GNOME extensions từ file vào một mảng
mapfile -t extensions < extension_list

# Lặp qua mảng và tắt từng extension
for extension in "${extensions[@]}"; do
    gnome-extensions enable "$extension"
done