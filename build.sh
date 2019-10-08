#!/usr/bin/env bash

#    __  __ ___ _   _ ___   __  __    _    _  _______
#   |  \/  |_ _| \ | |_ _| |  \/  |  / \  | |/ / ____|
#   | |\/| || ||  \| || |  | |\/| | / _ \ | ' /|  _|
#   | |  | || || |\  || |  | |  | |/ ___ \| . \| |___
#   |_|  |_|___|_| \_|___| |_|  |_/_/   \_\_|\_\_____|

## 1: MINIMAKE INIT. PUT THIS IN THE TOP OF YOUR SCRIPT

COMMANDS=()
COMMAND_DESC=()

make_command() {
  COMMANDS+=($1)
  COMMAND_DESC+=("$2")
}

usage(){
  printf "Usage: %s command\n\nCommands:\n" $0
  line="              "
  for (( i=0; i<=$(( ${#COMMANDS[*]} -1 )); i++ )); do
    printf "  %s %s ${COMMAND_DESC[$i]}\n" ${COMMANDS[$i]} "${line:${#COMMANDS[$i]}}"
  done
}

## 2: MINIMAKE DEFINE YOUR COMMANDS

make_command "readme" "Build README.md by merging minimake.sh into it"
readme(){
  cd "$(dirname "$0")" && cp README.md README.bak && csplit -s README.md '/```/1' {1} && echo '```' | cat - xx02 > xx99 && cat xx00 minimake.sh xx99 > README.md
  cd "$(dirname "$0")" && sed -ibak "s/^- very small*$/- very small, only $(wc -l minimake.sh| grep -o '[0-9]\+') lines of code, including documentation/" README.md
  cd "$(dirname "$0")" && rm xx*
  cd "$(dirname "$0")" && rm *bak
}

## 3:MINIMAKE EXECUTION
if test "$#" -eq 1 &&  [[ " ${COMMANDS[@]} " =~ $1 ]]; then
  eval "$1"
else
  usage
fi
