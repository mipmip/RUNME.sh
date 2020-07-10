# rake.sh

## Description

Mm is a tiny toolkit for creating bash cli utilities fast, simple and easy.

Minimake is so simple you could have written it yourself.

## This is minimake

```bash
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
```

### Why use rake.sh?

- ideal for small projects that need documented build scripts
- no dependencies
- very small, only 42 lines of code including documentation
- create fast scripts with commands as argument
- creates "USAGE:" banners without pain
- no learning needed
- no installation needed
- no special bash knowledge needed
- drop in solution to cleanup scripts
- drop in solution for quickly creating a dependency-free cli utility

### Why I wrote rake.sh

I often use make or make to create a tool with common tasks for small projects.
This is really overkill as I only need to run some tasks and add some quick
instructions for my later self. Rake.sh is as quick as those two but has no
dependancies.

## Usage, from scrath

1. copy minimake.sh as your new script filename
1. make it executable chmod +x ./yourscript.sh
1. remove the demo function and add your own functions as commands

## Usage, an existing bash script

1. Add minimake-part one on top of the existing file
1. Add minimake-part three at the bottom of your existing file
1. Add make_command entries above the functions you want to expose and move the
   old bash-code that's executed to these functions

## Example

For a live example *build.sh*. This is used to to build this README.md.

## Contributing

If you would like to help, please send pull request of submit an issue.

## License

Released under the MIT License. See the LICENSE file for further details.
