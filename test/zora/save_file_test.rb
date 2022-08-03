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

    def test_valid?
      assert save_file("Seasons_EU").valid?

      Tempfile.open do |file|
        refute SaveFile.new(file.path).valid?
      end
    end
  end
end
