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
  if test $NARGS -eq 1; then
    eval "$ARG1" || usage
  else
    usage
  fi
}
