<!-- markdownlint-configure-file { "MD041": { "level": 1 } } -->

# Usage

```shell
drawio-textconv [FLAGS] [FILE | -]
```

# Description

This tool extracts diagram source code from `.drawio` files
(compressed and uncompressed) and from `.drawio.svg` files (where
the diagram source is embedded).

Usually, you don’t run this tool directly but use it in combination
with Git’s `textconv` facility. This gives you meaningful diff
output, especially if you regularly check draw.io diagrams into Git
with sources embedded.

See **gitattributes**(5) for details on the `textconv` feature.

# Flags

The following flags are supported:

## `-c`, `--compressed`

Extract the `mxfile` source from a compressed `.drawio` XML file.

## `-u`, `--uncompressed`

Extract the `mxfile` source from an uncompressed `.drawio` XML file.

## `-s`, `--svg`

Extract the `mxfile` source from a `.drawio.svg` file.

# Setup

## Registering drawio-textconv with Git

To integrate drawio-textconv with Git on your system, open a
terminal and run the following command lines:

```sh
git config --global \
  diff.drawio-compressed.textconv \
  'drawio-textconv --compressed'

git config --global \
  diff.drawio-uncompressed.textconv \
  'drawio-textconv --uncompressed'

git config --global \
  diff.drawio-svg.textconv \
  'drawio-textconv --svg'

git config --global \
  diff.drawio-compressed.cachetextconv false

git config --global \
  diff.drawio-uncompressed.cachetextconv false

git config --global \
  diff.drawio-svg.cachetextconv false
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

# See also

**gitattributes**(5)
