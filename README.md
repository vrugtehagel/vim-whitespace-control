# VIM Whitespace control

Simple whitespace control for VIM.

The VIM Whitespace control plugin is an extremely simple and
lightweight solution for automatic whitespace detection. It looks
for the first indented bit of code, and uses that as indentation. It
does so when you open a file and when you save one. It only sets
the `tabstop` and `expandtab` options.

Additionally, the plugin removes trailing whitespace after saving, and cleans
up the indentation according to the detected type. Let's look at an example,
and to make things clear let's denote a space as `.` and a tab as `--->` (the
tabstop being 4).

```
/**
.*.This.function.finds.fibonacci.numbers.
.*/
export.function.fibonacci(index:.number):.number.{
--->if.(index.<=.1).{-->
--->....return.index;..
..->}.->..
....return.fibonacci(index.-.1).+.fibonacci(index.-.2);
}
```

This is a bit of a mess regarding whitespace. After saving, the plugin first
detects the indentation and assumes the desired indentation to be a tab, since
the first indented line uses one. Then, after processing, the file looks like

```
/**
.*.This.function.finds.fibonacci.numbers.
.*/
export.function.fibonacci(index:.number):.number.{
--->if.(index.<=.1).{
--->--->return.index;
--->}
--->return.fibonacci(index.-.1).+.fibonacci(index.-.2);
}
```

Note that it preseves the indentation in the JSDoc comment. Single-space indents
are disallowed, so the file is still detected as tab-indented. Within tab-based
indentation, trailing spaces are not removed (to avoid visual differences). In
general, the file should look the same after saving.

## Installation

This plugin requires the latest version of VIM (at least VIM 9). To install the
plugin, first navigate to your VIM plugins folder:

```bash
cd ~/.vim/pack/plugins/start
```

then clone this repository using

```bash
git clone git@github.com:vrugtehagel/vim-whitespace-control.git
```

And that's it!

