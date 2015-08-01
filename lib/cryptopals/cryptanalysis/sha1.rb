module Cryptopals
  module Cryptanalysis
    module SHA1
      class << self
        def length_extension(string, length, extension, mac)
          padding    = Digest::SHA1.padding(length)
          forged_mac = Digest::SHA1.digest(extension,
            length + padding.bytesize + extension.bytesize,
            mac.unpack('N5'))

          [string + padding + extension, forged_mac]
        end
      end
    end
  end
end
