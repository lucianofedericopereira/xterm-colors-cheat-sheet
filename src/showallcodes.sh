#!/bin/bash

echo 

echo "   Xterm 256 Colors"
echo 

deltas=(0 6 6 6 6 6 36 -6 -6 -6 -6 -6)
blocks=("16:21" "93:88" "160:165")
range=("232:243:1" "255:244:-1" "0:7:1" "8:15:1")

x(){
  local c=$1
  local fg=$(( (c >= 232 && c <= 243) ? 37 : 30 ))
  (( c >= 0 && c <= 255 )) && printf "   \e[1;%d;48;5;%dm %3d \e[0m" "$fg" "$c" "$c"
}

print_line() {
  local n=$1 acc=$n
  for d in "${deltas[@]}"; do
    acc=$((acc + d))
    x "$acc"
  done
  echo
  echo
}

print_range() {
  local start=$1 end=$2 step=$3
  for i in $(seq $start $step $end); do
    x "$i"
  done
  echo
}

for block in "${blocks[@]}"; do
  IFS=":" read start end <<< "$block"
  for n in $(seq $start $((start<end?1:-1)) $end); do
    print_line "$n"
  done
done

for r in "${range[@]}"; do
  IFS=":" read start end step <<< "$r"
  print_range "$start" "$end" "$step"
  echo
done
