require_relative 'challenge'

# Challenge 24: Create the MT19937 stream cipher and break it

class Challenge24 < Challenge
  def recover_seed_from_string_with_prefix(ciphertext, string)
    length = string.length
    prefix = "\0" * (ciphertext.length - length)

    (0..65535).find do |i|
      cipher = Cipher::MT19937.new(seed: i)
      result = cipher.encrypt(prefix + string)

      ciphertext[-length..-1] == result[-length..-1]
    end
  end

  def test_create_the_mt19937_stream_cipher_and_break_it
    seed = rand(0..65535)

    string = 'A' * 14
    cipher = Cipher::MT19937.new(seed: seed)
    ciphertext = cipher.encrypt(String.random(5..10) + string)

    assert_equal seed, recover_seed_from_string_with_prefix(ciphertext, string)
  end
end
