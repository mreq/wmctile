module Wmctile
  #
  # Memory remembers stuff about wmctile.
  # It stores, reads and updates a single yaml file in ~/.local/share/wmctile.
  #
  class Memory
    #
    # Memory init function. Creates a default yaml file if it's non-existent.
    #
    def initialize
      require 'yaml'
      read_file
    end

    #
    # Reads the yaml file, creating it if non-existent.
    #
    # @return [void]
    #
    def read_file
      @file_path = '~/.local/share/wmctile'
      @file_name = 'memory.yml'
      @file_full = File.expand_path([@file_path, @file_name].join('/'))

      if File.exist? @file_full
        file_contents = File.read(@file_full)
        @memory = YAML.load(file_contents)
      else
        create_file
        write_file
      end
    end

    #
    # Creates a new memory file with some default values.
    #
    # @return [void]
    #
    def create_file
      system "mkdir -p #{@file_path}"
      @memory = {
        window_history: [Wmctile.current_window_id],
        workspace_history: [Wmctile.current_workspace],
        workspace_data: {}
      }
    end

    #
    # Writes the current @memory to the memory file.
    #
    # @return [void]
    #
    def write_file
      file = File.new @file_full, 'w'
      file.puts @memory.to_yaml
      file.close
    end

    #
    # Gets a value from @memory.
    #
    # @param [Symbol] key Key to get.
    #
    # @return [String, Integer, Array, nil] Value from memory.
    #
    def get(key)
      @memory[key]
    end

    #
    # Sets a value to @memory.
    #
    # @param [Symbol] key Key to set.
    #
    # @return [void]
    #
    def set(key, value)
      @memory[key] = value
      trim(key) if @memory[key].is_a? Array
    end

    #
    # Deletes a value from @memory.
    #
    # @param [Symbol] key Key to delete.
    #
    # @return [void]
    #
    def delete(key)
      @memory.delete(key)
    end

    #
    # Appends a value to an array key.
    #
    # @param [Symbol] key The array key to append to
    # @param [Value] value The value to be appended
    #
    # @return [void]
    #
    def append(key, value)
      @memory[key] ||= []
      @memory[key] << value
      trim(key)
    end

    #
    # Trims the array key, keeping last 10 values.
    #
    # @param [Symbol] key The array key to be trimmed
    #
    # @return [void]
    #
    def trim(key)
      @memory[key] = @memory[key].last(10)
    end
  end
end
