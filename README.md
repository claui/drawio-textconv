# drawio-textconv

## What is this?

This command-line tool gives you meaningful diffs for `.drawio.svg`
and `.drawio` [diagrams](https://en.wikipedia.org/wiki/Diagrams.net)
that you have checked into Git.

It plugs into Git’s
[textconv](https://git-scm.com/docs/gitattributes#_performing_text_diffs_of_binary_files)
facility.

## Why do I need this?

This tool will give you meaningful diff output if you regularly
check draw.io diagrams into Git, especially diagrams with source
embedded into SVG (`.drawio.svg`).

If you have no idea what this means, then this tool is probably not
going to be useful to you.

## Installation

### Installing manually

Clone this repository to any directory you like.

Make sure the following packages are installed on your system:

- base64
- bash
- gunzip
- ruby
- sed
- xmllint
- xsltproc

### Installing from the AUR

Direct your favorite
[AUR helper](https://wiki.archlinux.org/title/AUR_helpers) to the
`drawio-textconv` package.

## Usage

See [`USAGE.md`](https://github.com/claui/drawio-textconv/blob/main/USAGE.md) for details.

## Contributing to drawio-textconv

See [`CONTRIBUTING.md`](https://github.com/claui/drawio-textconv/blob/main/CONTRIBUTING.md).

## See also

- [diagrams.net](https://en.wikipedia.org/wiki/Diagrams.net) on
  Wikipedia

- [textconv](https://git-scm.com/docs/gitattributes#_performing_text_diffs_of_binary_files)
  section in the
  [gitattributes](https://git-scm.com/docs/gitattributes)
  documentation

## License

Copyright (c) 2024 Claudia Pellegrino

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
For a copy of the License, see [LICENSE](LICENSE).
