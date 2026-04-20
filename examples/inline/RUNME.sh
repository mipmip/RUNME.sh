#!/usr/bin/env bash
#(C)2019-2026 Pim Snel - https://github.com/mipmip/RUNME.sh
CMDS=(); DESC=(); NARGS=$#; ARG1=$1;make_command(){ CMDS+=($1);DESC+=("$2");};usage(){ printf "\nUsage: %s [command]\n\nCommands:\n" $0;line="              ";for ((i=0;i<=$((${#CMDS[*]}-1));i++));do printf "  %s %s ${DESC[$i]}\n" ${CMDS[$i]} "${line:${#CMDS[$i]}}";done;echo;};RUNME_DIR="$(cd "$(dirname "$0")" && pwd)";if [ -d "$RUNME_DIR/RUNME.d" ]; then for _f in "$RUNME_DIR/RUNME.d"/*.sh; do [ -f "$_f" ] && source "$_f"; done;fi;runme(){ if test $NARGS -eq 1; then eval "$ARG1"||usage;else usage;fi;}

##### PLACE YOUR COMMANDS BELOW #####

make_command "hello" "Say hello world"
hello(){
  echo "Hello, world!"
}

make_command "greet" "Greet someone by name"
greet(){
  read -p "What is your name? " name
  echo "Hello, $name!"
}

make_command "info" "Show project info"
info(){
  echo "Project: inline example"
  echo "Directory: $(pwd)"
  echo "Date: $(date)"
}

##### PLACE YOUR COMMANDS ABOVE #####

runme
