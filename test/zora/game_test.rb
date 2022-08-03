# frozen_string_literal: true

require "test_helper"

module Zora
  class GameTest < Minitest::Test # rubocop:disable Metrics/ClassLength
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

    def test_kid_name # rubocop:disable Metrics/AbcSize
      assert_equal "Taco", save_files["Seasons_US"][1].kid_name
      assert_equal "James", save_files["Seasons_US"][2].kid_name
      assert_equal "Pip", save_files["Ages_US"][0].kid_name
      assert_nil save_files["Ages_JP"][0].kid_name
      assert_nil save_files["Ages_JP"][2].kid_name
    end

    def test_linked?
      assert save_files["Ages_US"][0].linked?
      refute save_files["Seasons_US"][1].linked?
      assert save_files["Seasons_US"][2].linked?
    end

    def test_hero_quest?
      refute save_files["Ages_US"][0].hero_quest?
      refute save_files["Seasons_US"][1].hero_quest?
      assert save_files["Seasons_US"][2].hero_quest?
    end

    def test_animal # rubocop:disable Metrics/AbcSize
      assert_equal "Dimitri", save_files["Ages_US"][0].animal
      assert_equal "Ricky", save_files["Seasons_US"][1].animal
      assert_equal "Moosh", save_files["Seasons_US"][2].animal
      assert_nil save_files["Ages_JP"][0].animal
    end

    def test_id
      assert_equal 14_129, save_files["Ages_US"][0].id
    end

    def test_behaviour
      assert_equal 4, save_files["Ages_US"][0].behaviour
    end

    def test_free_ring # rubocop:disable Metrics/AbcSize
      assert save_files["Ages_US"][0].free_ring?
      refute save_files["Ages_JP"][0].free_ring?
      assert save_files["Seasons_US"][1].free_ring?
      assert save_files["Seasons_US"][2].free_ring?
    end

    def test_rings # rubocop:disable Metrics/MethodLength
      expected = %w(
        PowerRingL1
        DoubleEdgeRing
        ProtectionRing
      )
      assert_equal expected, save_files["Ages_US"][0].rings

      expected = %w(
        FriendshipRing
        DiscoveryRing
      )
      assert_equal expected, save_files["Seasons_US"][1].rings

      expected = %w(
        FriendshipRing
        PowerRingL1
        PowerRingL2
        PowerRingL3
        ArmorRingL1
        ArmorRingL2
        RedRing
        BlueRing
        CursedRing
        BlastRing
        RangRingL1
        GBATimeRing
        MaplesRing
        SteadfastRing
        PegasusRing
        TossRing
        HeartRingL2
        ChargeRing
        LightRingL1
        GreenLuckRing
        BlueLuckRing
        GoldLuckRing
        RedLuckRing
        GreenHolyRing
        BlueHolyRing
        RedHolyRing
        SnowshoeRing
        RocsRing
        QuicksandRing
        BlueJoyRing
        GreenJoyRing
        DiscoveryRing
        OctoRing
        MoblinRing
        LikeLikeRing
        SubrosianRing
        DoubleEdgeRing
        GBANatureRing
        SlayersRing
        RupeeRing
        VictoryRing
        SignRing
        WhispRing
        GashaRing
        PeaceRing
        ZoraRing
        FistRing
        WhimsicalRing
        ProtectionRing
      )
      assert_equal expected, save_files["Seasons_US"][2].rings
    end

    private

    def save_files
      @save_files ||= %w(Seasons_US Seasons_EU Ages_US Ages_JP).to_h do |name|
        [name, SaveFile.new("test/saves/#{name}.srm")]
      end
    end
  end
end
