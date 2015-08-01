require_relative 'challenge'

# Challenge 6 (set 1): Break repeating-key XOR

class Challenge6 < Challenge
  def test_hamming
    assert_equal 37, 'this is a test'.hamming('wokka wokka!!!')
  end

  def test_break_repeating_key_xor
    ciphertext = open_data_file do |file|
      String.from_base64(file.readlines.map(&:chomp).join)
    end

    size = Cryptanalysis::Xor::RepeatingKey.guess_key_size(ciphertext, 2..40)

    assert_equal 'Terminator X: Bring the noise',
      Cryptanalysis::Xor::RepeatingKey.guess_key(ciphertext, size)
  end
end
