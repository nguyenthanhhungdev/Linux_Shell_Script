#!/bin/bash
sudo systemctl start cpupower.service
sudo cpupower frequency-set -g performance
sudo cpupower frequency-set -d 4000 all
cpupower frequency-info
sudo systemctl enable --now tuned
sudo tuned-adm active
sudo fancontrol
