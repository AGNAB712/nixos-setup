#!/usr/bin/env bash
export PATH=/run/current-system/sw/bin

# ---------------- cpu usage ----------------
get_cpu() {
  # read first sample
  read _ u1 n1 s1 i1 io1 irq1 sirq1 steal1 _ < /proc/stat
  total1=$((u1 + n1 + s1 + i1 + io1 + irq1 + sirq1 + steal1))
  idle1=$((i1 + io1))

  sleep 0.2

  # read second sample
  read _ u2 n2 s2 i2 io2 irq2 sirq2 steal2 _ < /proc/stat
  total2=$((u2 + n2 + s2 + i2 + io2 + irq2 + sirq2 + steal2))
  idle2=$((i2 + io2))

  diff_total=$((total2 - total1))
  diff_idle=$((idle2 - idle1))

  if [[ $diff_total -gt 0 ]]; then
    usage=$(( (100 * (diff_total - diff_idle)) / diff_total ))
    echo "$usage"
  else
    echo "0"
  fi
}

# ---------------- memory usage ----------------
get_mem() {
  mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  mem_avail=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

  if [[ -z "$mem_total" || "$mem_total" -eq 0 ]]; then
    echo "0"
    return
  fi

  used=$((mem_total - mem_avail))
  usage=$((100 * used / mem_total))

  echo "$usage"
}


# ---------------- dispatcher ----------------
case "$1" in
  --cpu)
    get_cpu
    ;;
  --mem)
    get_mem
    ;;
esac
