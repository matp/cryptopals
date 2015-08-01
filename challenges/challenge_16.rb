require_relative 'challenge'

# Challenge 16: CBC bitflipping attacks

class Challenge16 < Challenge
  def setup
    @cipher = Cipher::AES_128_CBC.new
    @prefix = 'comment1=cooking%20MCs;userdata='
    @suffix = ';comment2=%20like%20a%20pound%20of%20bacon'
  end

  def encrypt(string)
    @cipher.encrypt(@prefix + URI.encode_www_form_component(string) + @suffix)
  end

  def decrypt(ciphertext)
    @cipher.decrypt(ciphertext)
  end

  def test_cbc_bitflipping_attacks
    mask = "\0\0\0\0\0#{';admin=true' ^ '56789abcdef'}"
    ciphertext = encrypt('01234;admin=true' ^ mask)
    ciphertext[16, 16] ^= mask

    assert_match /;admin=true/, decrypt(ciphertext)
  end
end
