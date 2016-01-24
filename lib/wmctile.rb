#
# @author Petr Marek <contact@petrmarek.eu>
#
module Wmctile
  #
  # Notifies the user. Uses notify-send, when available. Otherwise falls back to echo.
  #
  # @param [String] message Message to be displayed.
  # @param [String] title Optional notify-send title.
  # @param [String] icon Icon to be displayed in the notification.
  #
  # @return [void]
  #
  def self.notify(message, title = 'wmctile', icon = 'error')
    system "if which notify-send > /dev/null; then notify-send -i '#{icon}' '#{title}' '#{message}'; else echo '#{message}'; fi"
  end

  #
  # Fetches windows from wcmtrl.
  #
  # @return [Array] Array of windows.
  #
  def self.window_list
    @window_list ||= `wmctrl -lx`.chomp.split(/\n/)
    @window_list
  end

  #
  # Fetches the current workspace number from wmctrl.
  #
  # @return [String] Current workspace number.
  #
  def self.current_workspace
    @current_workspace ||= `wmctrl -d | grep '\*' | cut -d' ' -f 1`.chomp.to_i
    @current_workspace
  end

  #
  # Fetches the current window id.
  #
  # @return [String] Current window id.
  #
  def self.current_window_id
    @current_window_id ||= `wmctrl -a :ACTIVE: -v 2>&1`.chomp.split('Using window: ')[1]
    @current_window_id
  end
end

require_relative 'wmctile/errors'
require_relative 'wmctile/memory'
require_relative 'wmctile/menu'
require_relative 'wmctile/router'
require_relative 'wmctile/window'
