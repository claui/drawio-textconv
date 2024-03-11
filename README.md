# drawio-textconv

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

```shell
drawio-textconv [FLAGS] [FILE | -]
```

The following flags are supported:

### `-c`, `--compressed`

Extract the `mxfile` source from a compressed `.drawio` XML file.

### `-u`, `--uncompressed`

Extract the `mxfile` source from an uncompressed `.drawio` XML file.

### `-s`, `--svg`

Extract the `mxfile` source from a `.drawio.svg` file.

## Contributing to drawio-textconv

See [`CONTRIBUTING.md`](https://github.com/claui/drawio-textconv/blob/main/CONTRIBUTING.md).

## License

Copyright (c) 2024 Claudia Pellegrino

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
For a copy of the License, see [LICENSE](LICENSE).
