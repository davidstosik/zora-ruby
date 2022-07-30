require "minitest/autorun"

require_relative "../../lib/zora/game"

module Zora
  class GameTest < Minitest::Test
    def test_version_returns_the_games_version
      game = Game.new("test/saves/Seasons_US.srm", 2)

      assert_equal "Z11216-0", game.version
    end

    def test_variant_returns_either_seasons_or_ages
      game = Game.new("test/saves/Seasons_US.srm", 2)

      assert_equal "Seasons", game.variant

      game = Game.new("test/saves/Ages_US.srm", 1)

      assert_equal "Ages", game.variant
    end

    def test_valid_returns_true_if_the_game_is_valid
      game = Game.new("test/saves/Seasons_US.srm", 2)

      assert game.valid?
    end

    def test_valid_returns_false_if_the_game_is_invalid
      game = Game.new("test/saves/Seasons_US.srm", 1)

      refute game.valid?
    end

    def test_name_returns_the_games_name
      game = Game.new("test/saves/Seasons_US.srm", 2)

      assert_equal "Kabi", game.name

      game = Game.new("test/saves/Seasons_US.srm", 3)

      assert_equal "Andy", game.name
    end
  end
end
