# frozen_string_literal: true

require_relative "game"

module Zora
  class SaveFile
    KILOBYTE = 1024
    SIZE = 8 * KILOBYTE

    def initialize(file_path)
      @file_path = file_path
    end

    def games
      0.upto(2).map { |i| Game.new(file_path, i) }
    end

    def valid?
      # TODO: figure out more validations
      File.size(file_path) == SIZE
    end

    private

    attr_reader :file_path
  end
end
