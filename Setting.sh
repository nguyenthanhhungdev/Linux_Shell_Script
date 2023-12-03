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
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_39/home:lamlng.repo
sudo dnf install ibus-bamboo
#Installing CPUPower
sudo dnf install kernel-tools
#Installing Perf
sudo dnf install perf
#Installing Dolphin
#Open dolphin with terminal: dolphin
sudo dnf install dolphin

