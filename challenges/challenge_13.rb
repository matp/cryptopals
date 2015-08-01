require_relative 'challenge'

# Challenge 13: ECB cut-and-paste

class Challenge13 < Challenge
  def setup
    @cipher = Cipher::AES_128_ECB.new
  end

  def profile_for(email)
    @cipher.encrypt("email=#{email.delete('&=')}&uid=100&role=user")
  end

  def profile_parse(profile)
    Hash[URI.decode_www_form(@cipher.decrypt(profile))]
  end

  def test_ecb_cut_and_paste
    # email=0123456789ab&uid=100&role=user
    # |----------------------------->|
    profile1 = profile_for('0123456789ab')

    # email=0123456789admin\v\v\v\v\v\v\v\v\v\v\v&uid=100&role=user
    #                 |------------------------>|
    profile2 = profile_for('0123456789' + 'admin'.pkcs7_pad(16))

    # email=0123456789ab&uid=100&role=admin\v\v\v\v\v\v\v\v\v\v\v
    # |----------------------------->|------------------------->|
    profile3 = profile1[0, 32] + profile2[16, 16]

    assert profile_parse(profile3)['role'] == 'admin'
  end
end
