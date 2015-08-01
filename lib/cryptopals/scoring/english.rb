module Cryptopals
  module Scoring
    class English
      # Industrial strength letter frequency analysis.
      def score(string)
        string = string.downcase
        string.chars.map {|char| FREQUENCY.index(char) || -1 }.reduce(:+)
      end

      private

        FREQUENCY = '!?. zqxjkvbpygfwmucldrhsnioate'
    end
  end
end
