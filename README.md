# minimake.sh

"So simple, you could have written it yourself"

## Description

Minimake is a tiny boilerplate for creating bash cli utilities very fast. It
helps creating tiny self documenting bash utilities without any dependencies.
It removes the pain of parsing command line options, writing "USAGE:" banners.
It's a copy/paste boilerplate and so simple you could have written it yourself.

## See for you self

This is minimake:

```bash
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

## REMOVE THIS WHEN YOU GET THE PICTURE
make_command "demo" "this command is for explaining how minimake works"
demo(){
  echo "This is a demo command"
}

## YOUR CODE HERE

## 3:MINIMAKE EXECUTION
if test "$#" -eq 1 &&  [[ " ${COMMANDS[@]} " =~ $1 ]]; then
  eval "$1"
else
  usage
fi
```

### Why Minimake?

- very small
- create fast scripts with commands as argument
- create usage banners without pain
- no learning needed
- no installation needed
- no special bash knowledge needed
- drop in solution to cleanup scripts
- drop in solution for quickly creating a dependency-free cli utility

## Usage, from scrath

1. copy minimake.sh as your new script filename
1. make it executable chmod +x ./yourscript.sh
1. remove the demo function and add your own functions as commands

## Usage, an existing bash script

1. Add minimake-part one on top of the existing file
1. Add minimake-part three at the bottom of your existing file
1. Add make_command entries above the functions you want to expose and move the
   old bash-code that's executed to these functions

## Contributing

If you would like to help, please send pull request of submit an issue.

## License

Released under the MIT License. See the LICENSE file for further details.
