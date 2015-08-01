require_relative 'challenge'

# Challenge 27: Recover the key from CBC with IV=Key

class Challenge27 < Challenge
  def setup
    @cipher = Cipher::AES_128_CBC.new(key: 'YELLOW SUBMARINE',
      iv: 'YELLOW SUBMARINE')
    @prefix = 'comment1=cooking%20MCs;userdata='
    @suffix = ';comment2=%20like%20a%20pound%20of%20bacon'
  end

  def encrypt(string)
    @cipher.encrypt(@prefix + URI.encode_www_form_component(string) + @suffix)
  end

  def decrypt(ciphertext)
    valid!(@cipher.decrypt(ciphertext))
  end

  def valid!(string)
    if string.bytes.any? {|byte| byte > 127 }
      raise ArgumentError, "invalid ASCII, #{string}"
    else
      string
    end
  end

  def test_recover_the_key_from_cbc_with_iv_equals_key
    begin
      ciphertext = encrypt('')
      ciphertext[16, 16] = "\0" * 16
      ciphertext[32, 16] = ciphertext[0, 16]
      decrypt(ciphertext)
    rescue ArgumentError => e
      string = e.message.sub(/^invalid ASCII, /, '')
    end

    assert_equal 'YELLOW SUBMARINE', string[0, 16] ^ string[32, 16]
  end
end
