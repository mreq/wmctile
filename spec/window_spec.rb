require_relative 'spec_helper'

module Wmctile
  describe Window do
    it 'works when given a valid id' do
      Window.new({}, `wmctrl -lx | tail -n1 | awk '{ print $3 }'`.chomp)
    end

    it 'throws an error when id\'s not found' do
      -> { Window.new({}, 'some_non_existing_nonsense') }.must_raise Errors::WindowNotFound
    end
  end
end
