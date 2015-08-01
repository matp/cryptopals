require_relative 'challenge'

# Challenge 29: Break a SHA-1 keyed MAC using length extension

class Challenge29 < Challenge
  def setup
    @secret = random_word
  end

  def secret_prefix_mac(string)
    Cryptopals::Digest::SHA1.digest(@secret + string)
  end

  def authenticate(string, mac)
    secret_prefix_mac(string) == mac
  end

  def test_break_a_sha1_keyed_mac_using_length_extension
    string = 'comment1=cooking%20MCs;userdata=foo;' \
      'comment2=%20like%20a%20pound%20of%20bacon'

    mac = secret_prefix_mac(string)

    result = (1..32).any? do |length|
      forged_string, forged_mac = Cryptanalysis::SHA1.length_extension(string,
        length + string.bytesize, ';admin=true', mac)
      authenticate(forged_string, forged_mac)
    end

    assert result
  end
end
