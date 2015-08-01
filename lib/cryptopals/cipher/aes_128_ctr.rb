module Cryptopals
  module Cipher
    class AES_128_CTR < AES_128_ECB
      attr_accessor :nonce

      def initialize(nonce: String.random(4).unpack('L').first, **options)
        super
        @nonce = nonce
      end

      def encrypt(string)
        perform(:encrypt) do |cipher|
          slices = string.byteslices(16).map.with_index do |slice, index|
            slice ^ cipher.update([@nonce, index].pack('Q<*'))
          end

          slices.join
        end
      end

      alias_method :decrypt, :encrypt
    end
  end
end
