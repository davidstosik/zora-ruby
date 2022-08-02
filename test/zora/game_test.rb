# frozen_string_literal: true

require "test_helper"

module Zora
  class GameTest < Minitest::Test
    def test_version_returns_the_games_version
      assert_equal "Z11216-0", games["Seasons_US"][1].version
    end

    def test_variant_returns_either_seasons_or_ages
      assert_equal "Seasons", games["Seasons_US"][1].variant
      assert_equal "Ages", games["Ages_US"][0].variant
    end

    def test_valid_returns_true_if_the_game_is_valid
      assert games["Seasons_US"][1].valid?
    end

    def test_valid_returns_false_if_the_game_is_invalid
      refute games["Seasons_US"][0].valid?
    end

    def test_name_returns_the_games_name # rubocop:disable Metrics/AbcSize
      assert_equal "Kabi", games["Seasons_US"][1].name
      assert_equal "Andy", games["Seasons_US"][2].name
      assert_equal "Link", games["Seasons_EU"][0].name
      assert_equal "Link", games["Ages_US"][0].name
      assert_equal "リンク", games["Ages_JP"][1].name
    end

    def test_from_file
      game = Game.from_file("test/saves/Seasons_EU.srm", 0)

      assert_equal "Z11216-0", game.version
      assert_equal "Link", game.name
    end

    def test_checksum
      assert_equal 0x5825, games["Seasons_EU"][0].checksum
      assert_equal 0x1BA3, games["Ages_JP"][1].checksum
      assert_equal 0x89BA, games["Seasons_US"][2].checksum
    end

    def test_calculate_checksum
      [
        ["Seasons_EU", 0],
        ["Ages_JP", 1],
        ["Seasons_US", 2],
      ].each do |name, index|
        game = games[name][index]
        assert_equal game.checksum, game.calculate_checksum
      end
    end

    private

    def games
      @games ||= %w(Seasons_US Seasons_EU Ages_US Ages_JP).map.to_h do |name|
        [
          name,
          0.upto(2).map do |index|
            Game.from_file("test/saves/#{name}.srm", index)
          end,
        ]
      end
    end
  end
end
