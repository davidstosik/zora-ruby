# frozen_string_literal: true

require "test_helper"

module Zora
  class GameTest < Minitest::Test
    def test_version_returns_the_games_version
      assert_equal "Z11216-0", save_files["Seasons_US"][1].version
    end

    def test_variant_returns_either_seasons_or_ages
      assert_equal "Seasons", save_files["Seasons_US"][1].variant
      assert_equal "Ages", save_files["Ages_US"][0].variant
    end

    def test_valid_returns_true_if_the_game_is_valid
      assert save_files["Seasons_US"][1].valid?
    end

    def test_valid_returns_false_if_the_game_is_invalid
      refute save_files["Seasons_US"][0].valid?
    end

    def test_name_returns_the_games_name # rubocop:disable Metrics/AbcSize
      assert_equal "Kabi", save_files["Seasons_US"][1].name
      assert_equal "Andy", save_files["Seasons_US"][2].name
      assert_equal "Link", save_files["Seasons_EU"][0].name
      assert_equal "Link", save_files["Ages_US"][0].name
      assert_equal "リンク", save_files["Ages_JP"][1].name
    end

    def test_checksum
      assert_equal 0x5825, save_files["Seasons_EU"][0].checksum
      assert_equal 0x1BA3, save_files["Ages_JP"][1].checksum
      assert_equal 0x89BA, save_files["Seasons_US"][2].checksum
    end

    def test_calculate_checksum
      [
        ["Seasons_EU", 0],
        ["Ages_JP", 1],
        ["Seasons_US", 2],
      ].each do |name, index|
        game = save_files[name][index]
        assert_equal game.checksum, game.calculate_checksum
      end
    end

    private

    def save_files
      @save_files ||= %w(Seasons_US Seasons_EU Ages_US Ages_JP).to_h do |name|
        [name, SaveFile.new("test/saves/#{name}.srm")]
      end
    end
  end
end
