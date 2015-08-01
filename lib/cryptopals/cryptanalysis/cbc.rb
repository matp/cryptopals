module Cryptopals
  module Cryptanalysis
    module CBC
      class << self
        def padding_oracle(ciphertext, iv, &block)
          ([iv] + ciphertext.byteslices(iv.bytesize))
            .each_cons(2)
            .map {|iv, slice| padding_oracle_decrypt_slice(iv, slice, &block) }
            .join
            .pkcs7_unpad
        end

        private

          class RetryError < StandardError; end

          def padding_oracle_decrypt_slice(iv, slice)
            String.new.tap do |string|
              (iv.bytesize - 1).downto(0) do |offset|
                byte = (0..255).find do |byte|
                  yield(slice, String.random(offset) \
                    + byte.chr \
                    + (string ^ iv[offset + 1..-1] ^ iv.bytesize - offset)) \
                    rescue false
                end

                if byte
                  string.prepend(byte.chr ^ iv[offset] ^ iv.bytesize - offset)
                else
                  raise RetryError
                end
              end
            end
          rescue RetryError
            # Above, we pick the first byte that yields a valid padding, which
            # may be a false positive. We can recover by simply starting over,
            # since the prefix is randomized.
            retry
          end
      end
    end
  end
end
