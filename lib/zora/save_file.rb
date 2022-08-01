require_relative "game"

module Zora
  class SaveFile
    def initialize(file_path)
      @file_path = file_path
    end

    def games
      0.upto(2).map { |i| Game.new(file_path, i) }
    end

    private

    attr_reader :file_path
  end
end
