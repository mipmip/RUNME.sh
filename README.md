# RUNME.sh

## Description

RUNME.sh is a tiny tiny toolkit for creating bash cli utilities fast, simple and easy.

Less is more. RUNME.sh is so simple you could have written it yourself.

### WHY

- Suckless: just one dependency.. a sh compatible shell
- Suckless: only 24 lines of code
- Little bash knowledge needed
- Makes "USAGE:" banners automatically
- Drop in solution to cleanup scripts
- Perfect for small projects

## Quickstart

* Run these 2 command in you project folder

```bash
curl -O https://raw.githubusercontent.com/mipmip/runme.sh/master/.runme.sh
curl -O https://raw.githubusercontent.com/mipmip/runme.sh/master/RUNME.sh && chmod +x RUNME.sh
```

* Edit RUNME.sh, add your commands
* Run it...

```bash
./RUNME.sh
```

### Why I wrote RUNME.sh

I often use make or rake for small projects. This is really overkill as I only
need to run some tasks and add some quick instructions for my later self.
RUNME.sh is as quick as those two but has no dependancies.

## Contributing

If you would like to help, please send pull request of submit an issue.

## License

Released under the MIT License. See the LICENSE file for further details.
