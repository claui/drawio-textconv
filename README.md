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

## Registering drawio-textconv with Git

To integrate drawio-textconv with Git on your system, open a
terminal and run the following command lines:

```sh
git config --global diff.drawio-compressed.textconv \
  'drawio-textconv --compressed'
git config --global diff.drawio-uncompressed.textconv \
  'drawio-textconv --uncompressed'
git config --global diff.drawio-svg.textconv \
  'drawio-textconv --svg'
git config --global diff.drawio-compressed.cachetextconv false
git config --global diff.drawio-uncompressed.cachetextconv false
git config --global diff.drawio-svg.cachetextconv false
```

## Enabling drawio-textconv for .drawio.svg files

To enable drawio-textconv for all `.drawio.svg` files in your Git
repository, add the following line to your `.gitattributes` file:

```plain
*.drawio.svg    text diff=drawio-svg
```

Confirm that it works:

```sh
$ git cat-file --textconv HEAD:path/to/my.drawio.svg
<?xml version="1.0"?>
<mxGraphModel grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fo
ld="1" page="1" pageScale="1" pageWidth="413" pageHeight="291" math="0" shadow="0">
  <root>
    […]
  </root>
</mxGraphModel>
```

Note: You can check your `.gitattributes` file into Git to share
this setting with other project members.

## Enabling drawio-textconv for .drawio files

If your Git repository has pure `.drawio` files instead of
`.drawio.svg`, you may want to check if your files are compressed.

If the files are uncompressed, then add the following line to your
`.gitattributes` file:

```plain
*.drawio    text diff=drawio-uncompressed
```

If the files are compressed, then add the following line to your
`.gitattributes` file:

```plain
*.drawio    text diff=drawio-compressed
```

## Usage

Usually, you don’t run this tool directly.

Refer to Git’s
[textconv](https://git-scm.com/docs/gitattributes#_performing_text_diffs_of_binary_files)
documentation to learn how to use this tool for diffs.

If you want to run this tool directly nonetheless, here’s how to use
it:

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
