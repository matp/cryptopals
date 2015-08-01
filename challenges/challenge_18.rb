require_relative 'challenge'

# Challenge 18: Implement CTR, the stream cipher mode

class Challenge18 < Challenge
  def test_implement_ctr_the_stream_cipher_mode
    ciphertext = String.from_base64(
      'L77na/nrFsKvynd6HzOoG7GHTLXsTVu9qvY/2syLXzhPweyyMTJULu/6/kXX0KSv' \
      'oOLSFQ==')

    cipher = Cipher::AES_128_CTR.new(key: 'YELLOW SUBMARINE', nonce: 0)

    assert_equal "Yo, VIP Let's kick it Ice, Ice, baby Ice, Ice, baby ",
      cipher.decrypt(ciphertext)
  end
end
