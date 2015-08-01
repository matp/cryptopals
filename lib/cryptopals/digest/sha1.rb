module Cryptopals
  module Digest
    module SHA1
      class << self
        def digest(string, length = string.bytesize, h = H)
          string += padding(length)

          h = [*h]

          string.byteslices(64).each do |slice|
            w = slice.unpack('N16')

            (16..79).each do |i|
              w[i] = leftrotate(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1)
            end

            a, b, c, d, e = h

            ( 0..79).each do |i|
              t = leftrotate(a, 5) + F[i / 20][b, c, d, e, w[i]]
              a, b, c, d, e = t & 0XFFFFFFFF, a, leftrotate(b, 30), c, d
            end

            [a, b, c, d, e].each_with_index do |x, i|
              h[i] = (h[i] + x) & 0XFFFFFFFF
            end
          end

          h.pack('N5')
        end

        def padding(length)
          bitlength = length << 3
          128.chr \
            << "\0" * (64 - (length + 9) % 64) \
            << [bitlength >> 32, bitlength & 0xFFFFFFFF].pack('N2')
        end

        private

          H = [ 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0 ]
          F = [
            ->(b, c, d, e, w) {
              ((b & c) | ((b ^ 0xFFFFFFFF) & d)) + e + w + 0x5A827999
            },
            ->(b, c, d, e, w) {
              (b ^ c ^ d) + e + w + 0x6ED9EBA1
            },
            ->(b, c, d, e, w) {
              ((b & c) | (b & d) | (c & d)) + e + w + 0x8F1BBCDC
            },
            ->(b, c, d, e, w) {
              (b ^ c ^ d) + e + w + 0xCA62C1D6
            }
          ]

          def leftrotate(word, bits)
            ((word << bits) & 0xFFFFFFFF) | (word >> (32 - bits))
          end
      end
    end
  end
end
