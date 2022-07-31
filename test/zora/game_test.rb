require "minitest/autorun"

require_relative "../../lib/zora/game"
require_relative "../../lib/zora/game_jp"

module Zora
  class GameTest < Minitest::Test
    def test_version_returns_the_games_version
      assert_equal "Z11216-0", games[:seasons][:us][1].version
    end

    def test_variant_returns_either_seasons_or_ages
      assert_equal "Seasons", games[:seasons][:us][1].variant
      assert_equal "Ages", games[:ages][:us][0].variant
    end

    def test_valid_returns_true_if_the_game_is_valid
      assert games[:seasons][:us][1].valid?
    end

    def test_valid_returns_false_if_the_game_is_invalid
      refute games[:seasons][:us][0].valid?
    end

    def test_name_returns_the_games_name
      assert_equal "Kabi", games[:seasons][:us][1].name
      assert_equal "Andy", games[:seasons][:us][2].name
      assert_equal "Link", games[:seasons][:eu][0].name
      assert_equal "Link", games[:seasons][:eu][1].name
      assert_equal "Link", games[:seasons][:eu][2].name
      assert_equal "Link", games[:ages][:us][0].name
      assert_equal "リンク", games[:ages][:jp][1].name
    end

    def test_name_returns_the_games_name_even_in_japanese
      path = "test/saves/Ages_JP-names.srm"
      assert_equal "か-びぃ-", GameJp.new(path, 0).name
      assert_equal "リンク", GameJp.new(path, 1).name
      assert_equal "カ-ピョ-", GameJp.new(path, 2).name
    end

    private

    def games
      @games ||= { seasons: %i(us eu), ages: %i(us jp) }.to_h do |variant, regions|
        [variant,
          regions.to_h do |region|
            [region,
             load_save_file(variant, region)]
          end]
      end
    end

    def load_save_file(variant, region)
      0.upto(2).map do |index|
        if region == :jp
          klass = GameJp
        else
          klass = Game
        end
        klass.new("test/saves/#{variant.to_s.capitalize}_#{region.to_s.upcase}.srm", index)
      end
    end
  end
end
