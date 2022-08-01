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
          next if byte == 0

          self::CHARSET[byte - 16]
        end.join
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
