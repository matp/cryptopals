module Cryptopals
  module Cryptanalysis
    module MT19937
      class << self
        def untemper(y)
          y ^= y >> 18
          y ^= (y << 15) & 4022730752
          y ^= (0..3).reduce(y << 7) {|x| (y ^ (x & 2636928640)) << 7 } \
            & 2636928640
          y ^= ((y >> 11) ^ y) >> 11
        end
      end
    end
  end
end
