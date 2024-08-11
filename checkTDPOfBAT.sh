#!/bin/bash

while true; do
  echo "Current TDP: "
  cat /sys/class/power_supply/BAT0/current_now /sys/class/power_supply/BAT0/voltage_now | xargs | awk '{print $1*$2/1e12 " W"}'
  sleep 4
done
