require_relative 'challenge'

# Challenge 10: Implement CBC mode

class Challenge10 < Challenge
  def test_implement_cbc_mode
    ciphertext = open_data_file do |file|
      String.from_base64(file.readlines.map(&:chomp).join)
    end

    cipher = Cipher::AES_128_CBC.new(key: 'YELLOW SUBMARINE', iv: "\0" * 16)

    assert_match /Play that funky music \n\Z/, cipher.decrypt(ciphertext)
  end
end
