require_relative 'spec_helper'

module Wmctile
  describe Router do
    it 'tries to create a window when needed' do
      router = Router.new({ use_active_window: true }, [])
      router.window.must_be_instance_of Window
    end

    it 'doesn\'t throw an error when a window id\'s not found and there\'s an --exec command' do
      router = Router.new({ exec: 'echo 1 > /dev/null' }, ['some_non_existing_nonsense'])
      router.window
    end
  end
end
