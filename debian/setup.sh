#!/bin/bash

# Hàm kiểm tra flathub đã được cài đặt chưa
check_flathub() {
  if flatpak remote-list | grep -q flathub; then
    echo "Flathub đã được cài đặt."
  else
    echo "Flathub chưa được cài đặt."
    echo "Tiến hành cài đặt flathub."
    sudo apt install flatpak
    sudo apt install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  fi
}

# Hàm cài đặt extension-manager
install_extension_manager() {
    if check_flathub; then
        echo "flathub đã được cài đặt, tiến hành cài đặt extension-manager."
        flatpak install flathub com.mattjakeman.ExtensionManager
    else
        echo "flathub chưa được cài đặt, thực hiện cài đặt"
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi
}

updateSystem() {
  sudo apt clean
  sudo apt update
  sudo apt upgrade -y

  # Firmware update
  sudo fwupdmgr refresh --force
  sudo fwupdmgr get-updates
  sudo fwupdmgr update
}

install_extensions() {
   mapfile -t extensions < extension_list
   for extension in "${extensions[@]}"; do
       gnome-extensions install "$extension"
   done
}

install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
}

install_nodejs() {
  sudo apt install -y nodejs
}

install_rclone() {
  sudo apt install -y rclone
}

install_rclone_browser() {
  sudo apt install -y rclone-browser
}

install_gnome_tweaks() {
  sudo apt install -y gnome-tweaks
}

install_java() {
  sudo apt install -y default-jdk
}

install_mongodb() {
  sudo apt install -y mongodb
}

install_httpd() {
  sudo apt install -y apache2
}

install_mysql() {
  sudo apt install -y mysql-server
}

install_ibus_bamboo() {
  sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
  sudo apt update
  sudo apt install -y ibus-bamboo
}

install_cpupower() {
  sudo apt install -y linux-tools-common linux-tools-generic
}

install_perf() {
  sudo apt install -y linux-perf
}

install_tuned() {
  sudo apt install -y tuned
}

install_fancontrol() {
  sudo apt install -y fancontrol
}

install_tuned_adm() {
  sudo apt install -y tuned
}

install_warp() {
  sudo apt install -y cloudflare-warp
}

install_grub_customizer() {
  sudo apt install -y grub-customizer
}

install_jetbrains_toolbox() {
  wget -c https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.2.31487.tar.gz
  sudo tar -xzf jetbrains-toolbox-2.3.2.31487.tar.gz -C ~/Downloads
  if [ "$?" -eq 0 ]; then
    gio trash jetbrains-toolbox-2.3.2.31487.tar.gz
  else
    echo "Có lỗi xảy ra khi giải nén JetBrains Toolbox."
  fi
}

install_git() {
  sudo apt install -y git
}

install_edge() {
  flatpak install flathub com.microsoft.Edge
}

install_vscode() {
  flatpak install flathub com.visualstudio.code
}

install_graphor() {
  flatpak install flathub org.gaphor.Gaphor
}

install_secret() {
  flatpak install flathub org.gnome.World.Secrets
}

install_warp() {
  flatpak install flathub app.drey.Warp
}

install_firmware_update() {
  flatpak install flathub org.gnome.Firmware
}

install_bottles() {
  flatpak install flathub com.usebottles.bottles
}

install_impression() {
  flatpak install flathub io.gitlab.adhami3310.Impression
}

install_iostat() {
  sudo apt install -y sysstat
}

install_upower() {
  sudo apt install -y upower
}

install_vitals() {
  sudo apt install -y libgtop2-dev lm-sensors
}

install_mongodb2() {
  sudo apt install -y mongodb-database-tools mongodb-mongosh mongodb-org
}

install_conky() {
  sudo apt install -y conky
}

install_obsidian() {
  flatpak install flathub md.obsidian.Obsidian
}

install_cyclictest() {
  sudo apt install -y rt-tests
}

install_volume_control() {
  flatpak install flathub org.pulseaudio.pavucontrol
}

install_kitty_terminal() {
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
}

main() {
  updateSystem
  install_extension_manager
  install_nvm
  install_nodejs
  install_rclone
  install_rclone_browser
  install_gnome_tweaks
  install_java
  install_mongodb
  install_httpd
  install_mysql
  install_ibus_bamboo
  install_cpupower
  install_perf
  install_tuned
  install_fancontrol
  install_tuned_adm
  install_warp
  install_grub_customizer
  install_jetbrains_toolbox
  install_git
  install_edge
  install_vscode
  install_graphor
  install_secret
  install_warp
  install_firmware_update
  install_bottles
  install_impression
  install_iostat
  install_upower
  install_vitals
  install_mongodb2
  install_extensions
  install_conky
  install_obsidian
  install_cyclictest
  install_volume_control
  install_kitty_terminal
}
main