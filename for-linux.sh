#!/bin/bash

simulate_ram_usage() {
  local size=$1
  local units=$2

  if [ "$units" = "GB" ]; then
    size_bytes=$(( size * 1024 * 1024 * 1024 ))
  elif [ "$units" = "MB" ]; then
    size_bytes=$(( size * 1024 * 1024 ))
  fi

  # Simulate RAM usage
  while true; do
    dd if=/dev/zero of=/dev/null bs="$size_bytes" count=1 >/dev/null 2>&1
  done
}

stop_simulation() {
  pkill -f "dd if=/dev/zero"
}

read -p "Simulation Size: " size
read -p "Units (GB/MB): " units

simulate_ram_usage "$size" "$units" &
pid=$!

read -p "Press enter to stop the simulation..."
stop_simulation

wait "$pid" >/dev/null 2>&1