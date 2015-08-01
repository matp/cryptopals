require_relative 'challenge'

# Challenge 12: Byte-at-a-time ECB decryption (Simple)

class Challenge12 < Challenge
  def test_byte_at_a_time_ecb_decryption_simple
    string = String.from_base64(
      'Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkgaGFp' \
      'ciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBqdXN0IHRv' \
      'IHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUgYnkK')

    cipher = Cipher::AES_128_ECB.new
    result = Cryptanalysis::ECB.decrypt_fixed_key do |input|
      cipher.encrypt(input + string)
    end

    assert_equal string, result
  end
end
