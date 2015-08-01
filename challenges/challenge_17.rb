require_relative 'challenge'

# Challenge 17: The CBC padding oracle

class Challenge17 < Challenge
  def test_the_cbc_padding_oracle
    strings = [
      'MDAwMDAwTm93IHRoYXQgdGhlIHBhcnR5IGlzIGp1bXBpbmc=',
      'MDAwMDAxV2l0aCB0aGUgYmFzcyBraWNrZWQgaW4gYW5kIHRoZSBWZWdhJ3MgYXJl' \
      'IHB1bXBpbic=',
      'MDAwMDAyUXVpY2sgdG8gdGhlIHBvaW50LCB0byB0aGUgcG9pbnQsIG5vIGZha2lu' \
      'Zw==',
      'MDAwMDAzQ29va2luZyBNQydzIGxpa2UgYSBwb3VuZCBvZiBiYWNvbg==',
      'MDAwMDA0QnVybmluZyAnZW0sIGlmIHlvdSBhaW4ndCBxdWljayBhbmQgbmltYmxl',
      'MDAwMDA1SSBnbyBjcmF6eSB3aGVuIEkgaGVhciBhIGN5bWJhbA==',
      'MDAwMDA2QW5kIGEgaGlnaCBoYXQgd2l0aCBhIHNvdXBlZCB1cCB0ZW1wbw==',
      'MDAwMDA3SSdtIG9uIGEgcm9sbCwgaXQncyB0aW1lIHRvIGdvIHNvbG8=',
      'MDAwMDA4b2xsaW4nIGluIG15IGZpdmUgcG9pbnQgb2g=',
      'MDAwMDA5aXRoIG15IHJhZy10b3AgZG93biBzbyBteSBoYWlyIGNhbiBibG93'
    ].map {|line| String.from_base64(line) }

    strings.each do |string|
      cipher = Cipher::AES_128_CBC.new
      result = Cryptanalysis::CBC.padding_oracle(
        cipher.encrypt(string), cipher.iv) do |input, iv|
        Cipher::AES_128_CBC.new(key: cipher.key, iv: iv).decrypt(input)
        true
      end

      assert_equal string, result
    end
  end
end
