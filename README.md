nvim-setup mexok
================

This repo fullfills two purposes:

1) Keep track of my config setup across multiple computers
2) Feel free to look around and copy setup if you see fit. But please notice, that this is a tailored setup which works for me and my thought processes. You propably think differently and therefore different customizations would be appropriate. This is intended as a source of inspiration as I also got inspired from other programmers.


Goals of my setup
=================

* Have an environment optimized for doing programming
* Don't move hand to mouse because it's annoying
* Don't use Ctrl so often because its kinda hard to reach if you have to do it often

To solve these goals, I've taken following steps:

* Utilize customized setup using tmux, nvim, zsh with oh-my-zsh
* Having shortbindings using Alt-Key quite often because I find it easy to reach with left-thumb


Things to notice
================

* I usually work with German keyboard, therefore I will have some keyboard bindings on keys like 'ö' because they are quite easy to reach or remappings of 'y' and 'z' because on a German keyboard they are switched and 'z' is easier to reach on a German keyboard than 'y'.
* I do 10 finger writing and don't look at my keyboard at all. If you do, I recommend learning 10 finger writing - starting yesterday.


How to setup
============

Because installation instructions may alter quickly, I've chosen to just put a list of things to install:

* OS: Ubuntu 22.04
* zsh and oh-my-zsh
* tmux
* nvim and vim-plug

Then copy the config files to their approriate locations:

* .config/ and .tmux.conf -> just copy paste to home dir
* .zshrc -> append to home dir .zshrc
* Install debugpy and pytest if needed
* Install nerdfont (I use DejaVu Sans Mono)

You can also use the setup.sh script, but it overrides some of your local configs, e.g. for tmux and neovim, so use with care.

...and you should be ready to go.

Feel free to reach out to me for problems/ issues.
