module Cryptopals
  module RNG
    class MT19937
      def initialize(seed = String.random(4).unpack('L').first)
        @index = 0
        @state = [seed]
        (1..623).each do |i|
          prev = @state[i - 1]
          @state << ((1812433253 * (prev ^ (prev >> 30)) + i) & 0xFFFFFFFF)
        end
      end

      def extract_number
        generate_numbers if @index == 0
        y = @state[@index]
        @index = (@index + 1) % 624
        y ^= y >> 11
        y ^= (y << 7) & 2636928640
        y ^= (y << 15) & 4022730752
        y ^= y >> 18
      end

      private

        def generate_numbers
          (0..623).each do |i|
            y = (@state[i] & 0x80000000) + (@state[(i + 1) % 624] & 0x7FFFFFFF)
            @state[i] = @state[(i + 397) % 624] ^ (y >> 1)
            @state[i] ^= 2567483615 if y.odd?
          end
        end
    end
  end
end
