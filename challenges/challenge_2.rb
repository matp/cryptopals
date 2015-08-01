require_relative 'challenge'

# Challenge 2: Fixed XOR

class Challenge2 < Challenge
  def test_fixed_xor
    string1 = String.from_hex('1c0111001f010100061a024b53535009181c')
    string2 = String.from_hex('686974207468652062756c6c277320657965')

    assert_equal String.from_hex('746865206b696420646f6e277420706c6179'),
      string1 ^ string2
  end
end
