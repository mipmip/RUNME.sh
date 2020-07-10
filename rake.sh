#!/usr/bin/env bash
# Copyright 2019 Pim Snel <pim@lingewoud.nl>

COMMANDS=(); COMMAND_DESC=(); NUMARGS=$#; ARG1=$1

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

run(){
  if test $NUMARGS -eq 1; then
    eval "$ARG1" || usage
  else
    usage
  fi
}
