# zeek-sublime

Zeek syntax highlighting definitions for
[Sublime Text](https://www.sublimetext.com) and
[TextMate](https://macromates.com).

## Sublime Text Installation

### Package Control

Install the "Zeek Language" package.  Highlighting will automatically
be provided for files ending in `.zeek` or `.bro`.

### Manual Installation

Go to `Preferences -> Browse Packages`, and then either download this repo's
contents to a directory named `Zeek` or use this command:

``` bash
git clone https://github.com/zeek/zeek-sublime Zeek
```

## Updating the Syntax Files

The `Zeek.YAML-tmLanguage` file is the one to edit.  The others are
generated from it with help from the `PackageDev` package, which you
must first install.  For example:

* With `Zeek.YAML-tmLanguage` open in SublimeText run command:
  `PackageDev: Convert (YAML, JSON, PList) to...`

* With `Zeek.tmLanguage` open in SublimeText run command:
  `Plugin Development: Convert Syntax to .sublime-syntax`

You can add syntax test cases to `syntax_test_.zeek` and, with that file open,
execute them by running the command: `Build With: Syntax Tests`
