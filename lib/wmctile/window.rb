module Wmctile
  #
  # Window is the core element of wmctile.
  # It is described by an id, which has to be fetched from a window_string.
  #
  class Window
    #
    # Window init function. Tries to find an id.
    #
    # @param [Hash] arguments command line options
    # @param [String] window_string command line string given
    #
    def initialize(arguments, window_string)
      @window_string = window_string
      @regexp_string = Regexp.new(window_string)
      find_window(arguments[:current_workspace])
    end

    #
    # Filters down the window_list to @matching_windows.
    #
    # @param [Boolean] current_workspace_only Should only the current workspace be used?
    #
    # @return [void]
    #
    def find_window(current_workspace_only = false)
      @matching_windows = Wmctile.window_list.grep(@regexp_string)
      filter_out_workspaces if current_workspace_only
      if @matching_windows.count > 1
        filter_more_matching_windows
      elsif @matching_windows.count == 1
        @matching_line = @matching_windows[0]
      else
        fail Errors::WindowNotFound, @window_string
      end
      extract_matching_line_information
    end

    #
    # Filters out @matching_windows so that only the ones on current_workspace remain.
    #
    # @return [Array] @matching_windows
    #
    def filter_out_workspaces
      @matching_windows = @matching_windows.grep(/^\w+\s+#{Wmctile.current_workspace}\s+/)
    end

    #
    # Takes the @matching_line and extracts @id, @workspace and @wm_class
    #
    # @return [void]
    #
    def extract_matching_line_information
      parts = @matching_line.split(/\s+/)
      @id = parts[0]
      @workspace = parts[1]
      @wm_class = parts[2]
    end

    #
    # Takes all the @matching_windows and finds the relevant one.
    # If the window is the same class as the current one, it loops to find the next one.
    # If the window is of a different class, it simply takes the first one.
    #
    # @return [void]
    #
    def filter_more_matching_windows
      ids = @matching_windows.map { |matching_window| matching_window.match(/^(\w+)\s/)[1] }
      target_index = 0
      if ids.include? Wmctile.current_window_id
        # Hold on to your hat, we're gonna loop!
        i = ids.index(Wmctile.current_window_id)
        if i + 1 < ids.count
          # Current window is not the last
          target_index = i + 1
        end
      end
      @matching_line = @matching_windows[target_index]
    end

    #
    # Switch to window's workspace and focus it.
    #
    # @return [void]
    #
    def switch_to
      return unless @id
      system "wmctrl -ia #{@id}"
    end

    #
    # Summon a window to current workspace and focus it.
    #
    # @return [void]
    #
    def summon
      return unless @id
      system "wmctrl -iR #{@id}"
    end

    #
    # Shade (minimize) or unshade a window.
    #
    # @param [Boolean] should_shade
    #
    # @return [void]
    #
    def toggle_shaded(should_shade = true)
      return unless @id

      if should_shade
        begin
          # Use xdotool if possible
          system "xdotool windowminimize #{@id}"
        rescue
          system "wmctrl -ir #{@id} -b add,shaded"
        end
      else
        system "wmctrl -ir #{@id} -b remove,shaded"
      end
    end

    #
    # Maximize or unmaximize a window.
    #
    # @param [Boolean] should_maximize
    #
    # @return [void]
    #
    def toggle_maximized(should_maximize = true)
      system "wmctrl -ir #{@id} -b #{should_maximize ? 'add' : 'remove'},maximized_vert,maximized_horz"
    end
  end
end
