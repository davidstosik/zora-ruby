require_relative "encodings"

module Zora
  class RawString
    class MissingEncoding < StandardError; end

    DEFAULT_ENCODING = Encodings::English

    attr_reader :data
    attr_accessor :encoding

    def initialize(data, encoding: nil)
      @data = data
      @encoding = encoding || detect_encoding
    end

    def to_s
      raise MissingEncoding unless encoding

      encoding.decode(data)
    end

    private

    def detect_encoding
      if valid_jp? && !valid_us?
        Encodings::Japanese
      elsif valid_us? && !valid_jp?
        Encodings::English
      end
    end

    def valid_jp?
      Encodings::Japanese.valid?(data)
    end

    def valid_us?
      Encodings::English.valid?(data)
    end
  end
end
