#!/bin/bash


#Hàm kiểm tra flathub đã được cài đặt chưa
check_flathub() {
  if flatpak remote-list | grep -q flathub; then
    echo "Flathub đã được cài đặt."
  else
    echo "Flathub chưa được cài đặt."
  fi
}


# Hàm cài đặt extension-manager
install_extension_manager() {
    if check_flathub; then
        echo "flathub đã được cài đặt, tiến hành cài đặt extension-manager."
        # Thực hiện cài đặt extension-manager ở đây
        flatpak install flathub com.mattjakeman.ExtensionManager
    else
        echo "flathub chưa được cài đặt, thực hiện cài đặt"
        # Thực hiện cài đặt flathub ở đây
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
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
install_extensions() {
   # Đọc danh sách UUID của các GNOME extensions từ file vào một mảng
   mapfile -t extensions < package.txt

   for i in "${extensions[@]}"
do
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${i}.zip "https://extensions.gnome.org/download-extension/${i}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${i}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
    fi
    gnome-extensions enable ${i}
    rm ${i}.zip
done
}

#Hàm install nvm
install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
}

#Hàm install nodejs
install_nodejs() {
  sudo dnf install nodejs
}

#Hàm install rclone
install_rclone() {
  sudo dnf install rclone
}

#Hàm install rclone-browser
install_rclone_browser() {
  sudo dnf install rclone-browser
}

#Hàm install gnome-tweaks
install_gnome_tweaks() {
  sudo dnf install gnome-tweaks
}

#Hàm install java
install_java() {
  sudo dnf install java
}

#Hàm install httpd
install_httpd() {
  sudo dnf install httpd
}

#Hàm install mysql
install_mysql() {
  sudo dnf install mysql
}

#Hàm install ibus-bamboo
install_ibus_bamboo() {
  sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_39/home:lamlng.repo
  sudo dnf install ibus-bamboo
}

#Hàm install cpupower
install_cpupower() {
  sudo dnf install kernel-tools
}

#Hàm install perf
install_perf() {
  sudo dnf install perf
}

#Hàm install tuned
install_tuned() {
  sudo dnf install tuned
}

#Hàm install fancontrol
config_boostFan() {
  sudo dnf install lm_sensors
  sudo pwmconfig
}

#Hàm install tuned-adm
install_tuned_adm() {
  sudo dnf install tuned-adm
}

#Hàm install warp
install_warp() {
  #Add repo
  sudo curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo
  #Install
  sudo dnf install cloudflare-warp
}

#Hàm install Grub Customizer
install_grub_customizer() {
  sudo dnf install grub-customizer
}

#Hàm install toolbox JetBrains
install_jetbrains_toolbox() {
	wget -c https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.2.31487.tar.gz
	sudo tar -xzf jetbrains-toolbox-2.3.2.31487.tar.gz -C ~/Downloads
	if [ "$?" -eq 0 ]; then
    gio trash jetbrains-toolbox-2.3.2.31487.tar.gz
  else
    echo "Có lỗi xảy ra khi giải nén JetBrains Toolbox."
  fi
}

#Hàm install git
install_git() {
  sudo dnf install git
}


#Hàm install vscode
install_vscode() {
  flatpak install flathub com.visualstudio.code
}

#Hàm install Gaphor
install_graphor() {
  flatpak install flathub org.gaphor.Gaphor
}

#Hàm install Secret
install_secret() {
  flatpak install flathub org.gnome.World.Secrets
}

#Hàm install Warp
install_warp() {
  flatpak install flathub app.drey.Warp
}

#Hàm install Firmware update
install_firmware_update() {
  flatpak install flathub org.gnome.Firmware
}

#Hàm install Bottles
install_bottles() {
  flatpak install flathub com.usebottles.bottles
}

#Hàm install Impression
install_impression() {
  flatpak install flathub io.gitlab.adhami3310.Impression
}

#Hàm install iostat
install_iostat() {
  sudo dnf install sysstat
}

#Hàm install upower
install_upower() {
  sudo dnf install upower
}

#Hàm install Vitals
install_vitals() {
  #Install Vitals (Wacthing detail of system)
  sudo dnf install libgtop2-devel lm_sensors
  #https://aur.archlinux.org/gnome-shell-extension-vitals-git.git
}

#Hàm install mongodb
install_mongodb1() {

# Bước 1: Thêm repo MongoDB
sudo tee /etc/yum.repos.d/mongodb-org-7.0.repo <<EOF
[mongodb-org-7.0]
name=MongoDB Repository
# Vào https://repo.mongodb.org/yum/redhat/ để xem phiên bản mới nhất
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
# https://www.mongodb.org/static/pgp/
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOF

# Bước 2: Cài đặt MongoDB
sudo dnf install -y mongodb-org

# Bước 3: Khởi động và kích hoạt MongoDB
sudo systemctl start mongod

# Kiểm tra trạng thái của MongoDB
sudo systemctl status mongod
}

# Hàm install conky
install_conky() {
  sudo dnf install conky
}

# Hàm install Obsidian
install_obsidian() {
  flatpak install flathub md.obsidian.Obsidian
}

# Hàm install Cyclictest
install_cyclictest() {
  sudo dnf install rt-tests
  sudo dnf install cyclictest
}

# Hàm install volume control
install_volume_control() {
  flatpak install flathub org.pulseaudio.pavucontrol
}

# Hàm install kitty terminal
install_kitty_terminal() {
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
}

# Hàm install snapd
install_snapd() {
  sudo dnf install snapd
}

# Hàm install ttyplot
install_ttyplot() {
  sudo snap install ttyplot
}

# Hàm install vivaldi
install_vivaldi() {
  flatpak install flathub com.vivaldi.Vivaldi
}

# Hàm install localsend
install_localsend() {
  flatpak install flathub org.localsend.localsend_app
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
  install_mongodb1
  install_httpd
  install_mysql
  install_ibus_bamboo
  install_cpupower
  install_perf
  install_tuned
  config_boostFan
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
  install_extensions
  install_conky
  install_obsidian
  install_cyclictest
  install_volume_control
  install_kitty_terminal
  install_snapd
  install_ttyplot
  install_vivaldi

}
main
