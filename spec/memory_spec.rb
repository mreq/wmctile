require_relative 'spec_helper'

module Wmctile
  describe Memory do
    describe 'yaml file' do
      it 'is able to create a memory yaml file' do
        file_name = File.expand_path('~/.local/share/wmctile/memory.yml')
        File.delete(file_name) if File.exist?(file_name)
        Memory.new
        File.exist?(file_name).must_equal true
      end

      it 'is able to read a memory yaml file' do
        file_name = File.expand_path('~/.local/share/wmctile/memory.yml')
        system "if ! grep -q 'test_key' #{file_name}; then echo ':test_key: 123' >> #{file_name}; fi"
        memory = Memory.new
        memory.get(:test_key).must_equal 123
        memory.delete(:test_key)
      end
    end

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

    describe 'array keys' do
      it 'trims to last 10 items' do
        memory = Memory.new
        memory.set(:test_array, (1..20).to_a)
        memory.get(:test_array).must_equal((11..20).to_a)
        memory.delete(:test_array)
      end
    end
  end
end
