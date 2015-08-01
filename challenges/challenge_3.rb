require_relative 'challenge'

# Challenge 3: Single-byte XOR cipher

class Challenge3 < Challenge
  def test_fixed_xor
    ciphertext = String.from_hex(
      '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b' \
      '3736')

    assert_equal 'Cooking MC\'s like a pound of bacon',
      Cryptanalysis::Xor::SingleByte.decrypt(ciphertext)
  end
end
