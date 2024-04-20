#!/bin/bash



# Hàm kiểm tra sự tồn tại của snapd
is_snapd_installed() {
    if rpm -q snapd &> /dev/null; then
        return 0  # snapd đã được cài đặt
    else
        return 1  # snapd chưa được cài đặt
    fi
}

# Hàm cài đặt extension-manager
install_extension_manager() {
    if is_snapd_installed; then
        echo "snapd đã được cài đặt, tiến hành cài đặt extension-manager."
        # Thực hiện cài đặt extension-manager ở đây
        sudo snap install gnome-extension-manager
    else
        echo "snapd chưa được cài đặt, thực hiện cài đặt"
        sudo apt install snapd
        sudo ln -s /var/lib/snapd/snap /snap
    fi
}

updateSystem() {
  sudo dnf clean all
  sudo dnf update
  sudo dnf upgrade

  #Firmware update
  sudo fwupdmgr refresh --force
  sudo fwupdmgr get-updates
  sudo fwupdmgr update
}

install_extension_manager