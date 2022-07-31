module Zora
  class Game
    KILOBYTE = 1024
    SAVE_GAME_SIZE = 8 * KILOBYTE
    DATA_OFFSET = 16
    DATA_SIZE = 1360
    ADDRESSES = {
      version: [2, 8],
      name: [82, 5]
    }

    CHARSET = <<~CHARSET.tr("\n", "")
      ●♣♦♠\0↑↓←→\0\0「」·\0。
       !\"\#$%&'()*+,-./
      0123456789:;<=>?
      @ABCDEFGHIJKLMNO
      PQRSTUVWXYZ[~]^\0
      \0abcdefghijklmno
      pqrstuvwxyz{￥}▲■
      ÀÂÄÆÇÈÉÊËÎÏÑÖŒÙÛ
      Ü\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
      àâäæçèéêëîïñöœùû
      ü\0\0\0\0\0\0\0\0\0\0\0\0♥\0\0
    CHARSET

    def initialize(path, index)
      @path = path
      @index = index
    end

    def version
      fetch(:version)
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
        File.size(path) == SAVE_GAME_SIZE && \
        %w(Seasons Ages).include?(variant)
    end

    def name
      fetch(:name).bytes.map do |byte|
        next if byte == 0
        self.class::CHARSET[byte-16]
      end.join
    end

    private

    attr_reader :path, :index

    def fetch(key)
      data.slice(*ADDRESSES[key])
    end

    def data
      @data ||= File.open(path) do |file|
        file.seek(DATA_OFFSET + index*DATA_SIZE)
        file.read(DATA_SIZE)
      end
    end
  end
end
