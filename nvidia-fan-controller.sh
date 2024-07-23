#!/bin/bash

min_fan_value="40"
max_fan_value="80"
delay="5"
startup_delay="120"

sleep "$startup_delay"
nvidia-settings -a "GPUFanControlState=1"

while true; do
    temp=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | tail -n 1`

    fan="$temp"
    if [[ "$fan" -le "$min_fan_value" ]]; then
        fan="$min_fan_value"
    elif [[ "$fan" -ge "$max_fan_value" ]]; then
        fan=100
    fi

    nvidia-settings -a "GPUTargetFanSpeed=$fan"
    sleep "$delay"
done