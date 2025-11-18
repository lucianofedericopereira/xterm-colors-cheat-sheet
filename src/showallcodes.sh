#!/bin/bash
printf "\n   Xterm 256 Colors\n\n"
x() {
  local c=$1 fg
  if (( c >= 232 && c <= 243 || c==8 )); then fg=37; else fg=30; fi
  printf "   \e[1;%d;48;5;%dm %3d \e[0m" "$fg" "$c" "$c"
}
print_line() {
  local s=$1 i c
  for ((i=0; i<12; i++)); do
    if (( i < 6 )); then
      c=$(( s + 6*i ))
    else
      c=$(( s + 66 - 6*(i-6) ))
    fi
    x "$c"
  done
  printf "\n\n"
}
print_n() {
  local v=$1 step=$2 n=$3 i
  for ((i=0; i<n; i++, v+=step)); do x "$v"; done
  printf "\n\n"
}
for r in 0 2 4; do
  base=$((16 + 36*r))
  dir=$(( r == 2 ))
  step=$(( 1 - 2*dir ))
  start=$(( dir * 5 ))
  for ((b=start; b!=start + 6*step; b+=step)); do
    print_line $(( base + b ))
  done
done
print_n 232  1 12
print_n 255 -1 12
print_n 0 1 8
print_n 8 1 8
