class String
  class << self
    def from_hex(string)
      raise ArgumentError, 'invalid hex' if string =~ /[^\da-fA-F]/
      [string].pack('H*')
    end
  end

  def to_hex
    unpack('H*').first
  end
end
