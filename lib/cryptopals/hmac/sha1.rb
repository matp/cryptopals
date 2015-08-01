module Cryptopals
  module HMAC
    module SHA1
      class << self
        def hmac(key, string)
          key  = Digest::SHA1.digest(key)   if key.bytesize > 64
          key += "\0" * (64 - key.bytesize) if key.bytesize < 64

          o_key_pad = "\x5C" * 64 ^ key
          i_key_pad = "\x36" * 64 ^ key

          Digest::SHA1.digest(o_key_pad \
            + Digest::SHA1.digest(i_key_pad + string))
        end
      end
    end
  end
end
