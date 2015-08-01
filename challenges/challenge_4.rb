require_relative 'challenge'

# Challenge 4 (set 1): Detect single-character XOR

class Challenge4 < Challenge
  def test_detect_single_character_xor
    ciphertexts = open_data_file do |file|
      file.readlines.map {|line| String.from_hex(line.chomp) }
    end

    scoring = Scoring::English.new
    strings = ciphertexts.map do |ciphertext|
      Cryptanalysis::Xor::SingleByte.decrypt(ciphertext, scoring)
    end

    assert_equal "Now that the party is jumping\n",
      strings.max_by {|string| scoring.score(string) }
  end
end
