module Cryptopals
  module Cryptanalysis
    module ECB
      class << self
        def count_non_unique_blocks(ciphertext, size)
          slices = ciphertext.byteslices(size)
          slices.length - slices.uniq.length
        end

        def detection_oracle(size)
          count_non_unique_blocks(yield("\0" * (size * 3 - 1)), size).nonzero?
        end

        def decrypt_fixed_key(size: nil, offset: nil, &block)
          size   ||= discover_block_size(&block)
          offset ||= guess_offset(size, &block)

          string = String.new.tap do |string|
            loop do
              input = "\0" * ((size - 1) - offset % size)
              ciphertext = yield(input)

              slice = [offset / size * size, size]
              string << (0..255).map(&:chr).find do |byte|
                ciphertext[*slice] == yield(input + string + byte)[*slice]
              end

              offset += 1

              break if offset + input.length == ciphertext.length
            end
          end

          string.pkcs7_unpad
        end

        private

          def discover_block_size
            length = yield("").length

            (1..Float::INFINITY)
              .lazy
              .map {|i| yield("\0" * i).length }
              .find {|length_increased| length_increased > length } - length
          end

          def guess_offset(size)
            index = nil

            offset = (0...size).find do |offset|
              index = yield("\0" * offset + String.random(size) * 2)
                .byteslices(size)
                .each_cons(2)
                .find_index {|x, y| x == y }
            end

            size - offset + (index - 1) * size if offset
          end
      end
    end
  end
end
