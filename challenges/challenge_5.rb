require_relative 'challenge'

# Challenge 5 (set 1): Implement repeating-key XOR

class Challenge5 < Challenge
  def test_implement_repeating_key_xor
    string =
      "Burning 'em, if you ain't quick and nimble\n" \
      "I go crazy when I hear a cymbal"

    assert_equal(String.from_hex(
      '0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a262263' \
      '24272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b2028' \
      '3165286326302e27282f'),
      string ^ 'ICE')
  end
end
