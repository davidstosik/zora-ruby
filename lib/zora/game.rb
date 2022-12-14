# frozen_string_literal: true

require_relative "raw_string"

module Zora
  class Game
    SIXTEEN_BIT_UNSIGNED_LITTLE_ENDIAN = "S<*"
    DATA_SIZE = 1360
    ADDRESSES = {
      version: [0x02, 0x08],
      name: [0x52, 0x05],
    }.freeze

    def initialize(data)
      @data = data
    end

    def version
      fetch(:version)
    end

    def variant
      case version[1]
      when "1" then "Seasons"
      when "2" then "Ages"
      else "Unknown"
      end
    end

    def valid?
      data.size == DATA_SIZE && \
        valid_checksum? && \
        %w(Seasons Ages).include?(variant)
    end

    def name
      RawString.new(fetch(:name)).to_s
    end

    def valid_checksum?
      checksum == calculate_checksum
    end

    def checksum
      data.unpack1(SIXTEEN_BIT_UNSIGNED_LITTLE_ENDIAN)
    end

    def calculate_checksum
      0xFFFF & \
        data[2..].unpack(SIXTEEN_BIT_UNSIGNED_LITTLE_ENDIAN).sum
    end

    private

    attr_reader :data

    def fetch(key)
      data.slice(*ADDRESSES[key])
    end
  end
end
