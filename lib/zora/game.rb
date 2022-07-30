module Zora
  class Game
    DATA_OFFSET = 16
    DATA_SIZE = 1360

    def initialize(path, index)
      @path = path
      @index = index
    end

    def version
      data = File.open(path) do |file|
        file.seek(DATA_OFFSET + (index-1)*DATA_SIZE)
        file.read(DATA_SIZE)
      end
      data[2, 8]
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
      data = File.open(path) do |file|
        file.seek(DATA_OFFSET + (index-1)*DATA_SIZE)
        file.read(DATA_SIZE)
      end
      data[82, 5].strip
    end

    private

    attr_reader :path, :index
  end
end
