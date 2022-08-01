# frozen_string_literal: true

require "test_helper"

module Zora
  class RawStringTest < Minitest::Test
    EXAMPLE_STRINGS = {
      link_capitalized: "\x4C\x69\x6E\x6B\x00",
      satoshi_katakana: "\xBA\xC3\xBB\x00\x00",
      satoshi_hiragana: "\x6a\x73\x6b\x00\x00",
      abcd: "\x61\x62\x63\x64\x00",
    }.freeze

    def test_detects_encoding_when_string_has_exclusive_characters
      assert_equal Encodings::English, build_raw_string(:link_capitalized).encoding
      assert_equal Encodings::Japanese, build_raw_string(:satoshi_katakana).encoding
    end

    def test_fails_detecting_encoding_when_string_has_no_exclusive_characters
      assert_nil build_raw_string(:abcd).encoding
    end

    def test_encoding
      raw_string = RawString.new(EXAMPLE_STRINGS[:abcd])
      assert_nil raw_string.encoding
      raw_string.encoding = Encodings::English
      assert_equal "abcd", raw_string.to_s
      raw_string.encoding = Encodings::Japanese
      assert_equal "いうえお", raw_string.to_s
    end

    def test_to_s
      assert_equal "Link", build_raw_string(:link_capitalized).to_s
      assert_equal "サトシ", build_raw_string(:satoshi_katakana).to_s
    end

    def test_to_s_raises_if_it_doesnt_know_the_encoding
      assert_raises(RawString::MissingEncoding) do
        build_raw_string(:abcd).to_s
      end
    end

    private

    def build_raw_string(name, encoding: nil)
      RawString.new(EXAMPLE_STRINGS[name], encoding: encoding)
    end
  end
end
