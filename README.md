# minimake.sh

"So simple, you could have written it yourself"

## Description

Minimake is a tiny boilerplate for creating bash cli utilities very fast. It
helps creating tiny self documenting bash utilities without any dependencies.
It removes the pain of parsing command line options, writing "USAGE:" banners.
It's a copy/paste boilerplate and so simple you could have written it yourself.

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
