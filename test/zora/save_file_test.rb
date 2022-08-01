require "test_helper"

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

    def test_valid?
      save_file = SaveFile.new("test/saves/Seasons_EU.srm")

      assert save_file.valid?

      Tempfile.open do |file|
        save_file = SaveFile.new(file.path)

        refute save_file.valid?
      end
    end
  end
end
