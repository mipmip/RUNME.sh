# RUNME

## Description

RUNME is a tiny toolkit for creating bash cli utilities fast, simple and easy.

RUNME is so simple you could have written it yourself.

### WHY

- suckless: 1 dependency.. a bash compatible shell
- suckless: only 24 lines of code
- makes "USAGE:" banners without pain
- little bash knowledge needed
- drop in solution to cleanup scripts
- perfect for small projects

## Quickstart

Run these 2 command in you project folder

```
curl -O https://raw.githubusercontent.com/mipmip/runme/master/.runme.sh
curl https://raw.githubusercontent.com/mipmip/runme/master/example.sh >> RUNME && chmod +x RUNME

1. edit RUNME and add your commands
1. try it

```bash
./RUNME
```

### Why I wrote rake.sh

I often use make or make to create a tool with common tasks for small projects.
This is really overkill as I only need to run some tasks and add some quick
instructions for my later self. Rake.sh is as quick as those two but has no
dependancies.

## Contributing

If you would like to help, please send pull request of submit an issue.

## License

Released under the MIT License. See the LICENSE file for further details.
