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
    # List of extension UUIDs to install
    EXTENSION_UUIDS=(
        "dash-to-dock@micxgx.gmail.com"
        "quick-settings-tweaks@qwreey"
        "transparent-window-moving@noobsai.github.com"
        "compiz-windows-effect@hermes83.github.com"
        "compiz-alike-magic-lamp-effect@hermes83.github.com"
        "Vitals@CoreCoding.com"
        "Rounded_Corners@lennart-k"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "background-logo@fedorahosted.org"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "clipboard-indicator@tudmotu.com"
        "blur-my-shell@aunetx"
        "workspaces-by-open-apps@favo02.github.com"
    )

    # Loop through each UUID and print the extension
    for UUID in "${EXTENSION_UUIDS[@]}"
    do
        echo "Extension: $UUID"
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

#Hàm install mongodb
install_mongodb() {
  sudo dnf install mongodb-org
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
  dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_39/home:lamlng.repo
  dnf install ibus-bamboo
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
install_fancontrol() {
  sudo dnf install fancontrol
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

#Hàm install edge
install_edge() {
  flatpak install flathub com.microsoft.Edge
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
  install_extensions
}

main
