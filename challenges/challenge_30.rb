require_relative 'challenge'

# Challenge 30: Break an MD4 keyed MAC using length extension

class Challenge30 < Challenge
  def setup
    @secret = random_word
  end

  def secret_prefix_mac(string)
    Cryptopals::Digest::MD4.digest(@secret + string)
  end

  def authenticate(string, mac)
    secret_prefix_mac(string) == mac
  end

  def test_md4
    assert_equal '31d6cfe0d16ae931b73c59d7e0c089c0',
      Cryptopals::Digest::MD4.digest('').to_hex
    assert_equal 'bde52cb31de33e46245e05fbdbd6fb24',
      Cryptopals::Digest::MD4.digest('a').to_hex
    assert_equal 'a448017aaf21d8525fc10ae87aa6729d',
      Cryptopals::Digest::MD4.digest('abc').to_hex
    assert_equal 'd9130a8164549fe818874806e1c7014b',
      Cryptopals::Digest::MD4.digest('message digest').to_hex
    assert_equal 'd79e1c308aa5bbcdeea8ed63df412da9',
      Cryptopals::Digest::MD4.digest('abcdefghijklmnopqrstuvwxyz').to_hex
    assert_equal '043f8582f241db351ce627e153e7f0e4',
      Cryptopals::Digest::MD4.digest(
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789').to_hex
    assert_equal 'e33b4ddc9c38f2199c3e7b164fcc0536',
      Cryptopals::Digest::MD4.digest('12345678901234567890' * 4).to_hex
  end

  def test_break_an_md4_keyed_mac_using_length_extension
    string = 'comment1=cooking%20MCs;userdata=foo;' \
      'comment2=%20like%20a%20pound%20of%20bacon'

    mac = secret_prefix_mac(string)

    result = (1..32).any? do |length|
      forged_string, forged_mac = Cryptanalysis::MD4.length_extension(string,
        length + string.bytesize, ';admin=true', mac)
      authenticate(forged_string, forged_mac)
    end

    assert result
  end
end
