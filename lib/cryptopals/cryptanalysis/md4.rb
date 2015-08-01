module Cryptopals
  module Cryptanalysis
    module MD4
      class << self
        def length_extension(string, length, extension, mac)
          padding    = Digest::MD4.padding(length)
          forged_mac = Digest::MD4.digest(extension,
            length + padding.bytesize + extension.bytesize,
            mac.unpack('V4'))

          [string + padding + extension, forged_mac]
        end
      end
    end
  end
end
