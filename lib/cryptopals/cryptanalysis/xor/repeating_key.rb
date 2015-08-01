module Cryptopals
  module Cryptanalysis
    module Xor
      module RepeatingKey
        class << self
          def guess_key_size(ciphertext, sizes)
            # Allow sizes for which we have at least two blocks worth of data.
            sizes = sizes.select {|size| size * 2 <= ciphertext.bytesize }

            # Find size with smallest hamming distance between blocks.
            sizes.min_by do |size|
              ciphertext.byteslices(size)
                        .each_cons(2)
                        .map {|x, y| x[0, y.length].hamming(y) }
                        .reduce(:+)
            end
          end

          def guess_key(ciphertext, size, scoring = Scoring::English.new)
            ciphertext.bytetranspose(size)
                      .map {|slice| SingleByte.guess_key(slice, scoring) }
                      .join
          end

          def decrypt(ciphertext, size, scoring = Scoring::English.new)
            ciphertext ^ guess_key(ciphertext, size, scoring)
          end
        end
      end
    end
  end
end
