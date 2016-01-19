Gem::Specification.new do |s|
  s.name        = 'wmctile'
  s.version     = '0.2.0'
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'wmctile'
  s.description = 'Window manager\'s best friend. In a gem.'
  s.authors     = ['mreq']
  s.email       = 'contact@petrmarek.eu'
  s.files       = Dir['bin/*'] + Dir['lib/*.rb'] + Dir['lib/wmctile/*.rb']
  s.homepage    = 'http://mreq.github.io/wmctile'
  s.license     = 'GPL-3'
  s.executables << 'wmctile'
  s.post_install_message = <<-eos
Thanks for installing wmctile. Make sure, you have the following dependencies installed on your system:

wmctrl
xrandr
dmenu

On Ubuntu it's as easy as running:

sudo apt-get install wmctrl suckless-tools

If you have that, run:

wmctile --help

to show the available commands.
  eos
end
