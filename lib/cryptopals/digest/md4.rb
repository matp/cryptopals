module Cryptopals
  module Digest
    module MD4
      class << self
        def digest(string, length = string.bytesize, h = H)
          string += padding(length)

          h = [*h]

          string.byteslices(64).each do |slice|
            w = slice.unpack('V16')

            a, b, c, d = h

            [0, 4, 8, 12].each do |i|
              a = leftrotate(a + F[0][b, c, d, w[i     ]],  3);
              d = leftrotate(d + F[0][a, b, c, w[i +  1]],  7);
              c = leftrotate(c + F[0][d, a, b, w[i +  2]], 11);
              b = leftrotate(b + F[0][c, d, a, w[i +  3]], 19);
            end

            [0, 1, 2, 3].each do |i|
              a = leftrotate(a + F[1][b, c, d, w[i     ]],  3);
              d = leftrotate(d + F[1][a, b, c, w[i +  4]],  5);
              c = leftrotate(c + F[1][d, a, b, w[i +  8]],  9);
              b = leftrotate(b + F[1][c, d, a, w[i + 12]], 13);
            end

            [0, 2, 1, 3].each do |i|
              a = leftrotate(a + F[2][b, c, d, w[i     ]],  3);
              d = leftrotate(d + F[2][a, b, c, w[i +  8]],  9);
              c = leftrotate(c + F[2][d, a, b, w[i +  4]], 11);
              b = leftrotate(b + F[2][c, d, a, w[i + 12]], 15);
            end

            [a, b, c, d].each_with_index do |x, i|
              h[i] = (h[i] + x) & 0xFFFFFFFF
            end
          end

          h.pack('V4')
        end

        def padding(length)
          bitlength = length << 3
          128.chr \
            << "\0" * (64 - (length + 9) % 64) \
            << [bitlength & 0XFFFFFFFF, bitlength >> 32].pack('V2')
        end

        private

          H = [ 0x67452301, 0XEFCDAB89, 0X98BADCFE, 0x10325476 ]
          F = [
            ->(b, c, d, w) {
              ((b & c) | ((b ^ 0XFFFFFFFF) & d)) + w
            },
            ->(b, c, d, w) {
              ((b & c) | (b & d) | (c & d)) + w + 0X5A827999
            },
            ->(b, c, d, w) {
              (b ^ c ^ d) + w + 0X6ED9EBA1
            }
          ]

          def leftrotate(word, bits)
            ((word << bits) & 0XFFFFFFFF) | ((word & 0XFFFFFFFF) >> (32 - bits))
          end
      end
    end
  end
end
