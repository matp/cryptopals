require_relative 'challenge'

# Challenge 25: Break "random access read/write" AES CTR

class Challenge25 < Challenge
  def setup
    @cipher = Cipher::AES_128_CTR.new
  end

  def encrypt(string)
    @cipher.encrypt(string)
  end

  def edit(ciphertext, offset, replacement)
    string = @cipher.decrypt(ciphertext)
    string[offset, string.length] = replacement
    encrypt(string)
  end

  def test_break_random_access_read_write_aes_ctr
    string = open_data_file do |file|
      cipher = Cipher::AES_128_ECB.new(key: 'YELLOW SUBMARINE')
      cipher.decrypt(String.from_base64(file.readlines.map(&:chomp).join))
    end

    ciphertext = encrypt(string)
    key = edit(ciphertext, 0, "\0" * ciphertext.length)

    assert_equal string, ciphertext ^ key
  end
end
