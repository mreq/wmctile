module Wmctile
  module Errors
    #
    # Class WindowNotFound provides an error class for Window
    #
    class WindowNotFound < StandardError
      def initialize(window_string)
        super(%(No matching window found for: "#{window_string}".))
      end
    end

    #
    # Class MenuExecutableNotFound provides an error to show when there's no way of grabbing input from the user.
    #
    class MenuExecutableNotFound < StandardError
      def initialize
        Wmctile.notify('No menu executable find. You need either rofi or dmenu.')
        super
      end
    end
  end
end
