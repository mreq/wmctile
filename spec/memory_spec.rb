require_relative 'spec_helper'

module Wmctile
  describe Memory do
    describe 'append' do
      it 'can append values to existing keys' do
        memory = Memory.new
        memory.append(:workspace_history, 999)
        history = memory.get(:workspace_history)
        history.last.must_equal 999
        # cleanup
        memory.set(:workspace_history, history - [999])
      end

      it 'creates a new array if needed' do
        memory = Memory.new
        time = Time.now.to_s.to_sym
        memory.append(time, 999)
        memory.get(time).must_equal [999]
        # cleanup
        memory.delete(time)
      end
    end
  end
end
