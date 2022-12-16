#!/usr/bin/env sh
#(C)2019-2022 Pim Snel - https://github.com/mipmip/RUNME.sh
CMDS=(); DESC=(); NARGS=$#; ARG1=$1

make_command() {
  CMDS+=($1)
  DESC+=("$2")
}

usage(){
  printf "\nUsage: %s [command]\n\nCommands:\n" $0
  line="              "
  for (( i=0; i<=$(( ${#CMDS[*]} -1 )); i++ )); do
    printf "  %s %s ${DESC[$i]}\n" ${CMDS[$i]} "${line:${#CMDS[$i]}}"
  done
  echo
}

runme(){
  if test $NARGS -gt 0; then
    eval "$ARG1" || usage
  else
    usage
  fi
}

##### PLACE YOUR COMMANDS BELOW #####


make_command "demo" "Demo RUNME.sh command showing all functions."
demo(){
  echo "showing the current directory"
  ls -al
}



##### PLACE YOUR COMMANDS ABOVE #####

runme
