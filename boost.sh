#!/bin/bash
sudo systemctl start tuned
sudo systemctl start cpupower.service
sudo cpupower frequency-set -g performance
sudo cpupower frequency-set -d 4000 all
cpupower frequency-info
sudo tuned-adm active
sudo tuned-adm verify
sudo fancontrol
