#
# @author Petr Marek <contact@petrmarek.eu>
#
module Wmctile
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
    @current_workspace ||= `wmctrl -d | grep '\*' | cut -d' ' -f 1`.chomp
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
require_relative 'wmctile/router'
require_relative 'wmctile/window'
