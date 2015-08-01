require_relative 'challenge'

# Challenge 15: PKCS#7 padding validation

class Challenge15 < Challenge
  def test_pkcs7_padding_validation
    assert_equal "ICE ICE BABY", "ICE ICE BABY\x04\x04\x04\x04".pkcs7_unpad
    assert_raises(ArgumentError) { "ICE ICE BABY\x05\x05\x05\x05".pkcs7_unpad }
    assert_raises(ArgumentError) { "ICE ICE BABY\x01\x02\x03\x04".pkcs7_unpad }
  end
end
