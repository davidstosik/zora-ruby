# frozen_string_literal: true

require "test_helper"
require "zora/save_file_helper"

module Zora
  class SaveFileTest < Minitest::Test
    include SaveFileHelper

    def test_games
      games = save_file("Seasons_EU").games

      assert_equal 3, games.size
      games.each do |game|
        assert game.is_a?(Game)
        assert_equal "Seasons", game.variant
        assert_equal "Link", game.hero_name
      end
    end

    def test_square_brackets
      save_file = save_file("Seasons_EU")

      0.upto(2).each do |index|
        assert save_file[index].is_a?(Game)
        assert_equal save_file.games[index], save_file[index]
      end
    end

    def test_valid?
      assert save_file("Seasons_EU").valid?

      Tempfile.open do |file|
        refute SaveFile.new(file.path).valid?
      end
    end
  end
end
