#!bin/bash

# This script maps color names to their Xterm 256-color indexes. The color_names 
# array defines the names in order, and the color_index associative array lets 
# you look up the index for any name. The _xansi function takes a name, finds its
# numeric index, and prints the correct ANSI escape sequence for that color. 
# xcolor sets the foreground, xbackground sets the background, and xreset restores
# default terminal colors.
#
# Example:
#
# echo -e "$(xcolor red)Red $(xreset)$(xbackground maroon) Maroon Background $(xreset) Normal Text"

color_names=(black maroon green olive navy purple-dark teal silver grey red lime yellow blue fuchsia aqua white grey-0 navy-blue dark-blue blue-3-dark blue-3-light blue-1 dark-green deep-sky-blue-4-dark deep-sky-blue-4-medium deep-sky-blue-4-light dodger-blue-3 dodger-blue-2 green-4 spring-green-4 turquoise-4 deep-sky-blue-3-dark deep-sky-blue-3-light dodger-blue-1 green-3-dark spring-green-3-dark dark-cyan light-sea-green deep-sky-blue-2 deep-sky-blue-1 green-3-light spring-green-3-light spring-green-2-dark cyan-3 dark-turquoise turquoise-2 green-1 spring-green-2-light spring-green-1 medium-spring-green cyan-2 cyan-1 dark-red-dark deep-pink-4-dark purple-4-dark purple-4-light purple-3 blue-violet orange-4-dark grey-37 medium-purple-4 slate-blue-3-dark slate-blue-3-light royal-blue-1 chartreuse-4 dark-sea-green-4-dark pale-turquoise-4 steel-blue steel-blue-3 cornflower-blue chartreuse-3-dark dark-sea-green-4-light cadet-blue-dark cadet-blue-light sky-blue-3 steel-blue-1-dark chartreuse-3-light pale-green-3-dark sea-green-3 aquamarine-3 medium-turquoise steel-blue-1-light chartreuse-2-dark sea-green-2 sea-green-1-dark sea-green-1-light aquamarine-1-dark dark-slate-gray-2 dark-red-light deep-pink-4-medium dark-magenta-dark dark-magenta-light dark-violet-dark purple-medium orange-4-light light-pink-4 plum-4 medium-purple-3-dark medium-purple-3-light slate-blue-1 yellow-4-dark wheat-4 grey-53 light-slate-grey medium-purple light-slate-blue yellow-4-light dark-olive-green-3-dark dark-sea-green light-sky-blue-3-dark light-sky-blue-3-light sky-blue-2 chartreuse-2-light dark-olive-green-3-medium pale-green-3-light dark-sea-green-3 dark-slate-gray-3 sky-blue-1 chartreuse-1 light-green-dark light-green-light pale-green-1-dark aquamarine-1-light dark-slate-gray-1 red-3-dark deep-pink-4-light medium-violet-red magenta-3-dark dark-violet-light purple-light dark-orange-3-dark indian-red-dark hot-pink-3-dark medium-orchid-3 medium-orchid medium-purple-2-dark dark-goldenrod light-salmon-3-dark rosy-brown grey-63 medium-purple-2-light medium-purple-1 gold-3-dark dark-khaki navajo-white-3 grey-69 light-steel-blue-3 light-steel-blue yellow-3-dark dark-olive-green-3-light dark-sea-green-2-dark dark-sea-green-2-medium light-cyan-3 light-sky-blue-1 green-yellow dark-olive-green-2 pale-green-1-light dark-sea-green-2-light dark-sea-green-1-dark pale-turquoise-1 red-3-light deep-pink-3-dark deep-pink-3-light magenta-3-medium magenta-3-light magenta-2-dark dark-orange-3-light indian-red-light hot-pink-3-light hot-pink-2 orchid medium-orchid-1-dark orange-3 light-salmon-3-light light-pink-3 pink-3 plum-3 violet gold-3-light light-goldenrod-3 tan misty-rose-3 thistle-3 plum-2 yellow-3-light khaki-3 light-goldenrod-2-dark light-yellow-3 grey-84 light-steel-blue-1 yellow-2 dark-olive-green-1-dark dark-olive-green-1-light dark-sea-green-1-light honeydew-2 light-cyan-1 red-1 deep-pink-2 deep-pink-1-dark deep-pink-1-light magenta-2-light magenta-1 orange-red-1 indian-red-1-dark indian-red-1-light hot-pink-dark hot-pink-light medium-orchid-1-light dark-orange salmon-1 light-coral pale-violet-red-1 orchid-2 orchid-1 orange-1 sandy-brown light-salmon-1 light-pink-1 pink-1 plum-1 gold-1 light-goldenrod-2-medium light-goldenrod-2-light navajo-white-1 misty-rose-1 thistle-1 yellow-1 light-goldenrod-1 khaki-1 wheat-1 cornsilk-1 grey-100 grey-3 grey-7 grey-11 grey-15 grey-19 grey-23 grey-27 grey-30 grey-35 grey-39 grey-42 grey-46 grey-50 grey-54 grey-58 grey-62 grey-66 grey-70 grey-74 grey-78 grey-82 grey-85 grey-89 grey-93)

declare -A color_index
for i in "${!color_names[@]}"; do
  color_index["${color_names[$i]}"]=$i
done

_xansi() {
  local type="$1"
  local name="$2"
  local idx="${color_index[$name]}"
  [[ -z "$idx" ]] && return 1
  printf "\e[${type};5;${idx}m"
}

xcolor() {
  _xansi 38 "$1"
}

xbackground() {
  _xansi 48 "$1"
}

xreset() {
  printf "\e[0m"
}

