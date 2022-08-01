require "minitest/autorun"

require_relative "../../lib/zora/save_file"

module Zora
  class SaveFileTest < Minitest::Test
    def test_games
      save_file = SaveFile.new("test/saves/Seasons_EU.srm")
      games = save_file.games

      assert_equal 3, games.size
      games.each do |game|
        assert game.is_a?(Game)
        assert_equal "Seasons", game.variant
        assert_equal "Link", game.name
      end
    end
  end
end
