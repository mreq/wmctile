# wmctile

Window manager's best friend. In a gem.

## Requirements

Wmctile works with `wmctrl` and `xdotool`. To use it, install the appropriate packages. On Ubuntu it's as easy as running:

```
sudo apt-get install wmctrl xdotool
```

To be able to work with menus (not required), you'll also need either [rofi](https://davedavenport.github.io/rofi/) or [dmenu](http://tools.suckless.org/dmenu/).

## Installation

Due to performance reasons of RVM, it's preferred to clone this repository and symlink the executable to your `$PATH`:

```
git clone git@github.com:mreq/wmctile.git ~/whatever/place/wmctile
cd ~/bin; ln -s ~/whatever/place/wmctile/bin/wmctile .
```

If the 700ms-ish lag caused by RVM is not a problem, you can simply:

```
gem install wmctile
```

## Usage

See `wmctile --help`

## Contribution

Is welcome. You'll need to clone, `bundle install` and run `guard`. Happy hacking :)

## Documentation

Done in yard - http://www.rubydoc.info/github/mreq/wmctile/master.
