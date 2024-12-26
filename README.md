# VIM Whitespace control

Simple whitespace control for VIM.

The VIM Whitespace control plugin is an extremely simple and
lightweight solution for automatic whitespace detection. It looks
for the first indented bit of code, and uses that as indentation. It
does so when you open a file and when you save one. It only sets
the `tabstop` and `expandtab` options.

Additionally, the plugin removes trailing whitespace after saving.

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

