#!/bin/bash

sudo dnf clean all
sudo dnf update
sudo dnf upgrade

#Install Vitals (Wacthing detail of system)
sudo dnf install libgtop2-devel lm_sensors
#https://aur.archlinux.org/gnome-shell-extension-vitals-git.git

#Installing git
sudo dnf install git

#Installing java
sudo dnf install java-latest-openjdk.x86_64

#Installing Mysql
sudo dnf install community-mysql-server

#Installing MongoDB
#sudo nano /etc/yum.repos.d/mongodb-org-x.x.repo
#[mongodb-org-x.x] trên trang install mongo db
#name=MongoDB Repository
#baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/6.0/x86_64/
#gpgcheck=1
#enabled=1
#gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc
sudo dnf install mongodb-org

#Installing httpd to control localhost
sudo dnf install httpd

#Installing nano
sudo dnf install nano

#Installing Bamboo
dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_39/home:lamlng.repo
dnf install ibus-bamboo

#Installing CPUPower
sudo dnf install kernel-tools

#Installing Perf
sudo dnf install perf

#Installing RCLone
#https://rclone.org/downloads/
#Installing RCLone Brower
sudo dnf install rclone-browser

#Install tweak
sudo dnf install gnome-tweaks
#Custom theme: https://youtu.be/viffvWtMTdo?si=bUcnHMwU9D_1bH2o
#Install gnome-extension
sudo apt install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install gnome-extension-manager
#Install Blur my shell, Vitals, Dash to dock, coverflow alt-tab, rounded conner, User Themes, transparent-window-moving, CipBoard indicator
#Install Bottles, caprine, timeshift, devdocs, format lab, dev toolbox

#Installing Caprine
sudo dnf copr enable dusansimic/caprine
sudo dnf install caprine


#Firmware update
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
#Enable RPM Fusition
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core
#Install 1.1.1.1
#Add repo
sudo curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo
#Install
sudo dnf install cloudflare-warp
#Install Nodejs
sudo dnf install nodejs

#Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# Nếu gặp lỗi k tìm thấy nvm thì: source ~/.nvm/nvm.sh
#Nếu lỡ cài nvm bằng npm thì gõ bằng cách dùng quyền root: rm -rf ~/.nvm
                                                           #rm -rf ~/.npm
                                                           #rm -rf ~/.bower
#Sau đó cài bằng curl

#Installing Grub custom
sudo dnf install grub-customizer
