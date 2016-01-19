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
  end
end
