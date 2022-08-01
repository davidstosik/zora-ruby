# frozen_string_literal: true

require_relative "raw_string"

module Zora
  class Game
    KILOBYTE = 1024
    SAVE_GAME_SIZE = 8 * KILOBYTE
    DATA_OFFSET = 0x10
    DATA_SIZE = 1360
    ADDRESSES = {
      version: [0x02, 0x08],
      name: [0x52, 0x05],
    }.freeze

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
      RawString.new(fetch(:name)).to_s
    end

    private

    attr_reader :path, :index

    def fetch(key)
      data.slice(*ADDRESSES[key])
    end

    def data
      @data ||= File.open(path) do |file|
        file.seek(DATA_OFFSET + index * DATA_SIZE)
        file.read(DATA_SIZE)
      end
    end
  end
end
