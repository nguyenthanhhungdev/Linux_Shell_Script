#!/bin/bash
sudo fancontrol
sudo systemctl status tuned
sudo systemctl start cpupower.service
sudo cpupower frequency-set -g performance
sudo cpupower frequency-set -d 4000 all
sudo tuned-adm active
sudo tuned-adm verify
