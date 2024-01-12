#!/bin/bash
#Install Vitals (Wacthing detail of system)
sudo dnf install libgtop2-devel lm_sensors
#https://aur.archlinux.org/gnome-shell-extension-vitals-git.git
#Installing git
sudo dnf install git
#Installing java
sudo dnf install java-latest-openjdk.x86_64
#Installing Mysql
sudo dnf install community-mysql-server
#Installing nano
sudo dnf install nano
#Installing Bamboo
#https://software.opensuse.org//download.html?project=home%3Alamlng&package=ibus-bamboo
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_39/home:lamlng.repo
sudo dnf install ibus-bamboo
#Installing CPUPower
sudo dnf install kernel-tools
#Installing Perf
sudo dnf install perf
#Installing Dolphin
#Open dolphin with terminal: dolphin
sudo dnf install dolphin
#Installing RCLone
#https://rclone.org/downloads/
#Installing RCLone Brower
sudo dnf install rclone-browser
#Install tweak
sudo dnf install gnome-tweaks
#Install gnome-extension
sudo dnf install gnome-shell-extensions
#Install Blur my shell, Vitals, Task Widget, Dash to dock, coverflow alt-tab, rounded conner, User Themes, transparent-window-moving
#Firmware update
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
#Enable RPM Fusition
sudo dnf install \https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
