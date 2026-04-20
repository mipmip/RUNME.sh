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

I often used `make` or `rake` for small projects. This is really overkill as I
only need to run some tasks and add some quick instructions for my later self.
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

## RUNME.d/ — one file per command

When your RUNME.sh grows, you can split commands into separate files. Create a
`RUNME.d/` directory next to your `RUNME.sh` and add one `.sh` file per command:

```
my-project/
├── RUNME.sh
└── RUNME.d/
    ├── deploy.sh
    ├── test.sh
    └── clean.sh
```

Each file uses the same `make_command` pattern:

```bash
# RUNME.d/deploy.sh
make_command "deploy" "Deploy to production"
deploy(){
  rsync -av ./dist/ server:/app/
}
```

Files are sourced in alphabetical order. Inline commands in RUNME.sh and
RUNME.d/ fragments work together — use both or either.

## Examples

See the [examples/](examples/) directory:

* [examples/inline/](examples/inline/) — all commands in a single RUNME.sh
* [examples/runme-d/](examples/runme-d/) — commands split into RUNME.d/ files

## rme — a command launcher for RUNME.sh

Want shell completions and a central `make`-like command? See [rme](https://github.com/mipmip/rme).

```bash
$ cd my-project
$ rme <TAB>
deploy  test  clean
$ rme deploy
```

## Contributing

If you would like to help, please send pull request of submit an issue.

## License

Released under the MIT License. See the LICENSE file for further details.
