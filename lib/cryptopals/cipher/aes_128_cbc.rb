require 'openssl'

module Cryptopals
  module Cipher
    class AES_128_CBC < AES_128_ECB
      attr_accessor :iv

      def initialize(iv: String.random(16), **options)
        super
        @iv = iv
      end

      def encrypt(string)
        perform(:encrypt) do |cipher|
          iv = @iv
          string.pkcs7_pad(16)
                .byteslices(16)
                .map {|slice| iv = cipher.update(iv ^ slice) }
                .join
        end
      end

      def decrypt(ciphertext)
        super.byteslices(16)
             .zip([@iv] + ciphertext.byteslices(16))
             .map {|x, y| x ^ y }
             .join
             .pkcs7_unpad
      end

      protected

        def openssl_options
          super.merge(iv: @iv, padding: 0)
        end
    end
  end
end
