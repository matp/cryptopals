require_relative 'challenge'

# Challenge 9 (set 2): Implement PKCS#7 padding

class Challenge9 < Challenge
  def test_implement_pkcs7_padding
    assert_equal "YELLOW SUBMARINE\x04\x04\x04\x04",
      'YELLOW SUBMARINE'.pkcs7_pad(20)
  end
end
