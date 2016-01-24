module Wmctile
  #
  # Class Menu provides a way of grabbing input from the user.
  # Uses rofi when possible, falls back to dmenu. If none are present, throws an error.
  #
  class Menu
    #
    # Initializes a input-grabbing menu.
    #
    # @param [Array] items Array of options for the menu.
    # @param [Integer] items_to_select Number of options to be selected.
    # @param [String] prompt Prompt for rofi.
    #
    def initialize(items, items_to_select = 1, prompt = 'wmctile')
      @items = items
      @items_to_select = items_to_select
      @prompt = prompt
      select_input_method
      puts grab_input
    end

    #
    # Tries to find rofi or dmenu in the system.
    # Throws Errors::MenuExecutableNotFound if it doesn't succeed.
    #
    # @return [void]
    #
    def select_input_method
      @has_rofi = executable? 'rofi'
      if @has_rofi
        @executable = 'rofi -dmenu -p "#{@prompt}: "'
      else
        @has_dmenu = executable? 'dmenu'
        @executable = 'dmenu' if @has_dmenu
      end
      fail Errors::MenuExecutableNotFound if @executable.nil?
    end

    #
    # Helper method for finding executables.
    #
    # @param [String] name Name of the executable.
    #
    # @return [Boolean] Does the executable exist?
    #
    def executable?(name)
      `which #{name} > /dev/null && echo yes_it_does`.chomp == 'yes_it_does'
    end

    #
    # Grabs the input from user, using the executable from `select_input_method`.
    #
    #
    # @return [String] User's input
    #
    def grab_input
      `echo "#{@items.join('\n')}" | #{@executable}`
    end
  end
end
