# wmctile

Window manager's best friend. In a gem.

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
