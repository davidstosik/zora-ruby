# frozen_string_literal: true

module Zora
  module Encodings
    class English
      CHARSET = <<~CHARSET.tr("\n", "")
        ●♣♦♠\0↑↓←→\0\0「」·\0。
         !\"\#$%&'()*+,-./
        0123456789:;<=>?
        @ABCDEFGHIJKLMNO
        PQRSTUVWXYZ[~]^\0
        \0abcdefghijklmno
        pqrstuvwxyz{￥}▲■
        ÀÂÄÆÇÈÉÊËÎÏÑÖŒÙÛ
        Ü\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
        àâäæçèéêëîïñöœùû
        ü\0\0\0\0\0\0\0\0\0\0\0\0♥\0\0
      CHARSET

      NAME_CHARACTERS = <<~CHARS.tr("\n", "")
        ♣♦♠♥·!'(),-.:;=
        ABCDEFGHIJKLMNOPQRSTUVWXYZ
        abcdefghijklmnopqrstuvwxyz
        ÀÂÄÆÇÈÉÊËÎÏÑÖŒÙÛÜ
        àâäæçèéêëîïñöœùûü
      CHARS

      def self.decode(raw_string)
        raw_string.bytes.map do |byte|
          next if byte.zero?

          self::CHARSET[byte - 16]
        end.join
      end

      def self.encode(string)
        string.chars.map do |char|
          self::CHARSET.index(char) + 16
        end.pack("C*") << "\0"
      end

      def self.valid?(raw_string)
        decode(raw_string).chars - self::NAME_CHARACTERS.chars == []
      end
    end

    class Japanese < English
      CHARSET = <<~CHARSET.tr("\n", "")
        \0\0\0\0♥↑↓←→\0\0「」\0\0。
         !\"\#$%&'()*+,ー./
        0123456789:;<=>?
        @ABCDEFGHIJKLMNO
        PQRSTUVWXYZ[~]^\0
        あいうえおかきくけこさしすせそた
        ちつてとなにぬねのはひふへほまみ
        むめもやゆよらりるれろをわんぁぃ
        ぅぇぉっゃゅょがぎぐげござじずぜ
        ぞだぢづでどばびぶべぼぱぴぷぺぽ
        アイウエオカキクケコサシスセソタ
        チツテトナニヌネノハヒフヘホマミ
        ムメモヤユヨラリルレロワヲンァィ
        ゥェォッャュョガギグゲゴザジズゼ
        ゾダヂヅデドバビブベボパピプペポ
      CHARSET

      NAME_CHARACTERS = <<~CHARS.tr("\n", "")
        ー
        あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろをわん
        ぁぃぅぇぉっゃゅょがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ
        アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン
        ァィゥェォッャュョガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポ
      CHARS
    end
  end
end
