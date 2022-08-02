# frozen_string_literal: true

require_relative "game"

module Zora
  class SaveFile
    KILOBYTE = 1024
    SIZE = 8 * KILOBYTE
    GAME_DATA_OFFSET = 0x10

    def initialize(file_path)
      @file_path = file_path
    end

    def [](index)
      @games ||= []
      @games[index] ||= read_game(index)
    end

    def games
      0.upto(2).map do |index|
        self[index]
      end
    end

    def valid?
      # TODO: figure out more validations
      File.exist?(file_path) && \
        File.size(file_path) == SIZE
    end

    private

    attr_reader :file_path

    def read_game(index)
      Game.new File.read(file_path, Game::DATA_SIZE, GAME_DATA_OFFSET + index * Game::DATA_SIZE)
    end
  end
end
