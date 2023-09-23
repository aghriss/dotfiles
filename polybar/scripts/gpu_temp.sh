#!/bin/sh

# echo GPU $(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)°C
echo GPU $(nvidia-smi --query-gpu=memory.used,power.draw,temperature.gpu --format=csv,noheader)°C
