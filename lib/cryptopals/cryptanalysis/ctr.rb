module Cryptopals
  module Cryptanalysis
    module CTR
      class << self
        def guess_fixed_nonce_key(ciphertexts, scoring = Scoring::English.new)
          ciphertexts.map(&:chars)
                     .reduce(&:zip)
                     .map(&:join)
                     .map {|slice| Xor::SingleByte.guess_key(slice, scoring) }
                     .join
        end

        def decrypt_fixed_nonce(ciphertexts, scoring = Scoring::English.new)
          key = guess_fixed_nonce_key(ciphertexts, scoring)
          ciphertexts.map {|ciphertext| ciphertext ^ key }
        end
      end
    end
  end
end
