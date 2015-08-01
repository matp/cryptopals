module Cryptopals
  module Cryptanalysis
    module Xor
      module SingleByte
        class << self
          def guess_key(ciphertext, scoring = Scoring::English.new)
            (0..255).max_by {|byte| scoring.score(ciphertext ^ byte.chr) }
                    .chr
          end

          def decrypt(ciphertext, scoring = Scoring::English.new)
            ciphertext ^ guess_key(ciphertext, scoring)
          end
        end
      end
    end
  end
end
