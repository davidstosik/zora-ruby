# frozen_string_literal: true

module Zora
  class SaveFile
    KILOBYTE = 1024
    SIZE = 8 * KILOBYTE
    GAME_DATA_OFFSET = 0x10

    def initialize(file_path)
      @file_path = file_path
    end

    def [](index)
      games[index]
    end

    def games
      @games ||= read_games
    end

    def valid?
      # TODO: figure out more validations
      File.exist?(file_path) && \
        File.size(file_path) == SIZE && \
        games.any?(&:valid?)
    end

    private

    attr_reader :file_path

    def read_games
      0.upto(2).map do |index|
        read_game(index)
      end
    end

    def read_game(index)
      Game.new File.read(file_path, *game_address(index))
    end

    def game_address(index)
      [
        Game::DATA_SIZE,
        GAME_DATA_OFFSET + index * Game::DATA_SIZE,
      ]
    end
  end
end
