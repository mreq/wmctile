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
      puts @yaml_file
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
        @memory = Yaml.load(file_contents)
      else
        create_file
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
      write_memory
    end

    #
    # Writes the current @memory to the memory file.
    #
    # @return [void]
    #
    def write_memory
      file = File.new @file_full, 'w'
      file.puts @memory.to_yaml
      file.close
    end
  end
end
