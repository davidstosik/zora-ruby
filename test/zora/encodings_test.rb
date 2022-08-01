# frozen_string_literal: true

require "test_helper"

module Zora
  module Encodings
    class EnglishTest < Minitest::Test
      LINK_RAW_STRING = "\x4C\x69\x6E\x6B\x00"

      def test_decode
        assert_equal "Link", English.decode(LINK_RAW_STRING)
      end

      def test_valid
        assert English.valid?(LINK_RAW_STRING)
      end
    end

    class JapaneseTest < Minitest::Test
      KIRBY_RAW_STRING = "\x65\x2D\xA7\x8F\x2D"

      def test_decode
        assert_equal "かーびぃー", Japanese.decode(KIRBY_RAW_STRING)
      end

      def test_valid
        assert Japanese.valid?(KIRBY_RAW_STRING)
      end
    end
  end
end
