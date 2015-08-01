require_relative 'challenge'

# Challenge 20: Break fixed-nonce CTR statistically

class Challenge20 < Challenge
  def test_break_fixed_nonce_ctr_statistically
    cipher = Cipher::AES_128_CTR.new
    ciphertexts = open_data_file do |file|
      file.readlines.map do |line|
        string = String.from_base64(line.chomp)
        cipher.encrypt(string)
      end
    end

    result = Cryptanalysis::CTR.decrypt_fixed_nonce(ciphertexts)

    assert_match /And we outta here \/ Yo, what happened to peace\? \/ Peace/i,
      result.last
  end
end
