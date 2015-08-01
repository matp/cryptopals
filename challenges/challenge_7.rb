require_relative 'challenge'

# Challenge 7 (set 1): AES in ECB mode

class Challenge7 < Challenge
  def test_aes_in_ecb_mode
    ciphertext = open_data_file do |file|
      String.from_base64(file.readlines.map(&:chomp).join)
    end

    assert_match /Play that funky music \n\Z/,
      Cipher::AES_128_ECB.new(key: 'YELLOW SUBMARINE').decrypt(ciphertext)
  end
end
