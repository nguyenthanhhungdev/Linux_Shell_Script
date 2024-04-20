#!/bin/bash
echo "set government"
sudo cpupower frequency-set -g performance
echo "set frequency"
sudo cpupower frequency-set -d 4000 all
echo "Frequency Info"
cpupower frequency-info
sudo systemctl enable --now tuned
tuned-adm profile throughput-performance virtual-host network-throughput hpc-compute throughput-performance
echo "Profile tuned"
sudo tuned-adm active
sudo systemctl start fancontrol
sudo fancontrol