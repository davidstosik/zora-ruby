# frozen_string_literal: true

require "test_helper"

module Zora
  module Encodings
    HEX_STRING_TO_BINARY = "H*"

    class EnglishTest < Minitest::Test
      LINK_RAW_STRING = %w(4C696E6B00).pack(HEX_STRING_TO_BINARY)

      def test_decode
        assert_equal "Link", English.decode(LINK_RAW_STRING)
      end

      def test_valid
        assert English.valid?(LINK_RAW_STRING)
      end

      def test_encode
        assert_equal LINK_RAW_STRING, English.encode("Link")
      end
    end

    class JapaneseTest < Minitest::Test
      KIRBY_RAW_STRING = %w(652DA78F2D00).pack(HEX_STRING_TO_BINARY)

      def test_decode
        assert_equal "かーびぃー", Japanese.decode(KIRBY_RAW_STRING)
      end

      def test_valid
        assert Japanese.valid?(KIRBY_RAW_STRING)
      end

      def test_encode
        assert_equal KIRBY_RAW_STRING, Japanese.encode("かーびぃー")
      end
    end
  end
end
