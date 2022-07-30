module Zora
  class Game
    DATA_OFFSET = 16
    DATA_SIZE = 1360
    NAME_OFFSET = 82
    NAME_SIZE = 5
    VERSION_OFFSET = 2
    VERSION_SIZE = 8

    def initialize(path, index)
      @path = path
      @index = index
    end

    def version
      data[VERSION_OFFSET, VERSION_SIZE]
    end

    def variant
      case version[1]
      when "1" then "Seasons"
      when "2" then "Ages"
      else "Unknown"
      end
    end

    def valid?
      File.exist?(path) && \
        File.size(path) == 8*1024 && \
        %w(Seasons Ages).include?(variant)
    end

    def name
      data[NAME_OFFSET, NAME_SIZE].strip
    end

    private

    attr_reader :path, :index

    def data
      @data ||= File.open(path) do |file|
        file.seek(DATA_OFFSET + index*DATA_SIZE)
        file.read(DATA_SIZE)
      end
    end
  end
end
