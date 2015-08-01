require_relative 'challenge'

# Challenge 28: Implement a SHA-1 keyed MAC

class Challenge28 < Challenge
  def test_sha1
    assert_equal 'da39a3ee5e6b4b0d3255bfef95601890afd80709',
      Cryptopals::Digest::SHA1.digest('').to_hex
    assert_equal 'a9993e364706816aba3e25717850c26c9cd0d89d',
      Cryptopals::Digest::SHA1.digest('abc').to_hex
    assert_equal '84983e441c3bd26ebaae4aa1f95129e5e54670f1',
      Cryptopals::Digest::SHA1.digest(
        'abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq').to_hex
    assert_equal '34aa973cd4c4daa4f61eeb2bdbad27316534016f',
      Cryptopals::Digest::SHA1.digest('a' * 1_000_000).to_hex
    assert_equal 'dea356a2cddd90c7a7ecedc5ebb563934f460452',
      Cryptopals::Digest::SHA1.digest(
        '01234567012345670123456701234567' * 20).to_hex
  end

  def test_hmac_sha1
    assert_equal 'fbdb1d1b18aa6c08324b7d64b71fb76370690e1d',
      Cryptopals::HMAC::SHA1.hmac('', '').to_hex
    assert_equal 'de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9',
      Cryptopals::HMAC::SHA1.hmac('key',
        'The quick brown fox jumps over the lazy dog').to_hex
  end
end
