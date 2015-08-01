require_relative 'challenge'

# Challenge 8 (set 1): Detect AES in ECB mode

class Challenge8 < Challenge
  def test_detect_aes_in_ecb_mode
    ciphertexts = open_data_file do |file|
      file.readlines.map {|line| String.from_hex(line.chomp) }
    end

    result = ciphertexts.max_by do |ciphertext|
      Cryptanalysis::ECB.count_non_unique_blocks(ciphertext, 16)
    end

    assert_equal String.from_hex(
      'd880619740a8a19b7840a8a31c810a3d08649af70dc06f4fd5d2d69c744cd283' \
      'e2dd052f6b641dbf9d11b0348542bb5708649af70dc06f4fd5d2d69c744cd283' \
      '9475c9dfdbc1d46597949d9c7e82bf5a08649af70dc06f4fd5d2d69c744cd283' \
      '97a93eab8d6aecd566489154789a6b0308649af70dc06f4fd5d2d69c744cd283' \
      'd403180c98c8f6db1f2a3f9c4040deb0ab51b29933f2c123c58386b06fba186a'),
      result
  end
end
