require_relative 'challenge'

# Challenge 11: An ECB/CBC detection oracle

class Challenge11 < Challenge
  def test_an_ecb_cbc_detection_oracle_ecb
    is_ecb = Cryptanalysis::ECB.detection_oracle(16) do |input|
      cipher = Cipher::AES_128_ECB.new
      cipher.encrypt(String.random(5..10) << input << String.random(5..10))
    end

    assert is_ecb
  end

  def test_an_ecb_cbc_detection_oracle_cbc
    is_ecb = Cryptanalysis::ECB.detection_oracle(16) do |input|
      cipher = Cipher::AES_128_CBC.new
      cipher.encrypt(String.random(5..10) << input << String.random(5..10))
    end

    refute is_ecb
  end
end
