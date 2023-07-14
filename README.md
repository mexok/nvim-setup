nvim-setup mexok
================

This repo fullfills two purposes:

1) Keep track of my config setup across multiple computers
2) Be a source of inspiration for others as I also was inspired by the work of others


Goals of my setup
=================

* Have an environment optimized for doing programming
* Don't move hand to mouse because misclicking is annoying and interrupts the workflow
* Don't use pinky fingers too often as they are not so strong and hurt if used too often during long sessions

To solve these goals, I've taken following steps:

* Utilize a customized setup using nvim, tmux, zsh with oh-my-zsh
* Have a Kinesis Advantage 360 keyboard with custom keybindings, so that e.g. Ctrl + Shift are reachable with ring and middle fingers as they are stronger then pinky.


Things to notice
================

* I am from Germany and have adjusted the US-Layout coming with the 360 keyboard to fit in German special chars. I also applied mappings to them in NeoVIM, therefore I will have some keyboard bindings on keys like 'ö' or remappings of 'y' and 'z' because on my keyboard they are switched.
* I was also inspired by the idea of Helix using a selection -> action pattern instead of vim's default action -> selection pattern. Therefore, I have bindings to jump right into selection, e.g. 'c' -> 'viw'


How to setup
============

Please install:

* OS: Debian 12 (or similar)
* zsh and oh-my-zsh
* tmux
* nvim (0.9 from official tar.gz package) and packer
* I have included an install.sh which includes some of the above plus some more CLI-Tools I use

Then copy the config files to their approriate locations:

* .config/ and .tmux.conf -> just copy paste to home dir
* .zshrc -> append to home dir .zshrc
* Install nerdfont (I use DejaVu Sans Mono)

You can also use the setup.sh script, but it overrides some of your local configs, e.g. for tmux and neovim, so use with care.

Install programming specific language tools. I have not 'standardized' them for my setup yet.

Feel free to reach out to me for problems/ issues.
