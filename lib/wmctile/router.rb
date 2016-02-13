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
      @arguments = arguments
      @window_strings = window_strings

      if @window_strings.count > 0 || @arguments[:use_active_window]
        if arguments[:switch_to]
          window.switch_to
        elsif arguments[:summon]
          window.summon
        elsif arguments[:shade]
          window.toggle_shaded(true)
        elsif arguments[:unshade]
          window.toggle_shaded(false)
        elsif arguments[:maximize]
          window.toggle_maximized(true)
        elsif arguments[:unmaximize]
          window.toggle_maximized(false)
        elsif arguments[:move_to_workspace]
          window.move_to_workspace(arguments[:move_to_workspace])
        elsif arguments[:follow_to_workspace]
          window.move_to_workspace(arguments[:follow_to_workspace])
          # sleeps a bit so that the switch_to actually triggers correctly
          sleep 0.01
          window.switch_to
        end
      else
        if arguments[:switch_to_workspace]
          number = switch_to_workspace(arguments[:switch_to_workspace])
          Wmctile.memory.append(:workspace_history, number.to_i)
        end
      end
    end

    #
    # Creates a new window based on @arguments and @window_strings.
    # If no window is found, checks for the -x/--exec argument. If present, executes it.
    # If there's no -x command and a window is not found, raises an error.
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
        system "#{@arguments[:exec]} &"
      else
        raise Errors::WindowNotFound, @window_strings[index]
      end
    end

    #
    # Switch to target_workspace.
    #
    # @param [String] target_workspace Target workspace index or "next"/"previous".
    #
    # @return [Integer] Target workspace number
    #
    def switch_to_workspace(target_workspace)
      if target_workspace == 'next'
        target_workspace = Wmctile.current_workspace + 1
      elsif target_workspace == 'previous'
        target_workspace = Wmctile.current_workspace - 1
      end
      system "wmctrl -s #{target_workspace}"
      target_workspace
    end
  end
end
