#!/bin/bash
# Kiểm tra nếu thư mục grub2-themes đã tồn tại
if [ ! -d "grub2-themes" ]; then
    git clone https://github.com/vinceliuice/grub2-themes.git
fi
sudo ./install.sh -t tela -s 2k

# Kiểm tra nếu thư mục WhiteSur-gtk-theme đã tồn tại
if [ ! -d "WhiteSur-gtk-theme" ]; then
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
fi
cd WhiteSur-gtk-theme || exit

# Liệt kê các hình ảnh có trong thư mục hiện tại
# Các định dạng hình ảnh phổ biến: jpg, jpeg, png, gif, bmp, tiff

# Sử dụng lệnh find để tìm các tệp hình ảnh
images=$(find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \))

# Kiểm tra nếu không có hình ảnh nào
if [ -z "$images" ]; then
    echo "No image"
    read -p "Press 1 to set default or 2 to provide an image path: " choice
    if [ "$choice" -eq 1 ]; then
        echo "Set Default..."
        sudo ./tweaks.sh -g -b default
    elif [ "$choice" -eq 2 ]; then
        read -p "Enter the image path: " image_path
        if [ -f "$image_path" ]; then
            cp "$image_path" .
            image_name=$(basename "$image_path")
            sudo ./tweaks.sh -g -b "$image_name"
        else
            echo "Invalid image path."
        fi
    else
        echo "Invalid choice."
    fi
else
    # In tiêu đề
    echo "STT|    Tên hình ảnh"

    # Khởi tạo biến đếm
    count=1

    # Lặp qua danh sách hình ảnh và in ra
    while IFS= read -r image; do
        echo "$count|    $(basename "$image")"
        ((count++))
    done <<< "$images"
fi

# Cài đặt Wallpapers WhiteSur

if [ ! -d "WhiteSur-wallpapers" ]; then
  git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git
fi
cd WhiteSur-wallpapers || exit
sudo ./install-gnome-backgrounds.sh