module Wmctile
  #
  # Router is the backbone of wmctile.
  # It dispatches relevant methods based on the command-line arguments.
  #
  class Router
    #
    # Starts wmctile, runs the required methods.
    #
    # @param [Hash] command line options
    # @param [Array] window_strings ARGV array
    #
    def initialize(arguments, window_strings)
      return unless window_strings.count

      @arguments = arguments
      @window_strings = window_strings

      if arguments[:switch_to]
        window.switch_to
      elsif arguments[:summon]
        window.summon
      elsif arguments[:shade]
        window.toggle_shaded(true)
      elsif arguments[:unshade]
        window.toggle_shaded(false)
      end
    end

    #
    # Creates a new window based on @arguments and @window_strings.
    # If no window is found, checks for the -x/--exec argument. If present, executes it.
    #
    # @param [Integer] index index of the window from matching windows array
    #
    # @return [Window] window instance
    #
    def window(index = 0)
      if @arguments[:use_active_window]
        Window.new(@arguments, Wmctile.current_window_id)
      else
        Window.new(@arguments, @window_strings[index])
      end
    rescue Errors::WindowNotFound
      if @arguments[:exec]
        # Exec the command
        puts "Executing command: #{@arguments[:exec]}"
        `#{@arguments[:exec]} &`
      end
      raise Errors::WindowNotFound, @window_strings[index]
    end
  end
end
