# RUNME.sh

## Description

RUNME.sh is a suckless single-file boilerplate for creating bash cli utilities fast, simple and easy.

- Just one dependency: a sh compatible shell.
- Boilerplate has only 11 lines of code, including comments.
- Little bash knowledge needed
- Makes "USAGE:" banners automatically
- Drop in solution for cleaning up collections of scripts
- Perfect for self documenting small projects

> RUNME.sh is so simple you could have written it yourself.

### Why I wrote RUNME.sh

I often use `make` or `rake` for small projects. This is really overkill as I only
need to run some tasks and add some quick instructions for my later self.
RUNME.sh does exacly the same.

## Quickstart

* Run this command in you project folder

```bash
curl -O https://raw.githubusercontent.com/mipmip/runme.sh/master/RUNME.sh && chmod +x RUNME.sh
```

* Edit RUNME.sh, see how the demo command is works, and add your own commands
* Run it...

```bash
$ ./RUNME.sh

Usage: ./RUNME.sh command

Commands:
  demo            this command is for explaining how run-me works
```

## Contributing

If you would like to help, please send pull request of submit an issue.

## License

Released under the MIT License. See the LICENSE file for further details.
