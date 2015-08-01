require_relative 'challenge'

# Challenge 1: Convert hex to base64

class Challenge1 < Challenge
  def test_convert_hex_to_base64
    string = String.from_hex(
      '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f' \
      '69736f6e6f7573206d757368726f6f6d')

    assert_equal(
      'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t',
      string.to_base64)
  end

  def test_convert_base64_to_hex
    string = String.from_base64(
      'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t')

    assert_equal(
      '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f' \
      '69736f6e6f7573206d757368726f6f6d',
      string.to_hex)
  end
end
