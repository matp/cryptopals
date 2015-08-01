module Cryptopals
  module Cipher
    class MT19937
      def initialize(seed:)
        @rng = RNG::MT19937.new(seed)
      end

      def encrypt(string)
        string.byteslices(4)
              .map {|slice| slice ^ [@rng.extract_number].pack('L') }
              .join
      end

      alias_method :decrypt, :encrypt
    end
  end
end
