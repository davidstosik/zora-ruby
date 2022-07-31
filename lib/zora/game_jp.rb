module Zora
  class GameJp < Game
    CHARSET = <<~CHARSET.tr("\n", "")
      \0\0\0\0♥↑↓←→\0\0「」\0\0。
       !\"\#$%&'()*+,-./
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

    def name
      super.bytes.map do |byte|
        CHARSET[byte-16]
      end.join
    end
  end
end