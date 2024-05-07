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

function install_extensions {
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

    # Loop through each UUID and install the extension
    for UUID in "${EXTENSION_UUIDS[@]}"
    do
        gnome-extensions install $UUID
    done
}

updateSystem
install_extension_manager
install_extensions