require_relative 'spec_helper'

module Wmctile
  describe Window do
    it 'works when given a valid id' do
      Window.new({}, `wmctrl -lx | tail -n1 | awk '{ print $3 }'`.chomp)
    end

    it 'throws an error when id\'s not found' do
      -> { Window.new({}, 'some_non_existing_nonsense') }.must_raise Errors::WindowNotFound
    end

    it 'doesn\'t throw an error when id\'s not found and there\'s a -x command' do
      Window.new({ exec: 'echo 1 > /dev/null' }, 'some_non_existing_nonsense')
    end
  end
end
