#!/bin/bash

PACKAGE_LIST="/debian/package.txt"

install_packages() {
	echo "Updating package list..."
	sudo apt update

	echo "Installing apt packages..."
	install_from_list "$PACKAGE_LIST"
}

install_from_list() {
	local list_file="$1"
	if [ -f "$list_file" ]; then
		sudo apt install -y $(<"$list_file")
	else
		echo "APT Package list file not found: $list_file"
	fi
}