class String
  def ^(other)
    other = other.chr   if other.is_a?(Integer)
    other = other.bytes if other.is_a?(String)

    unless other.is_a?(Enumerable) \
      && other.all? {|byte| (0..255).include?(byte) }
      raise ArgumentError, 'invalid byte sequence' 
    end

    bytes.zip(other.cycle).map {|x, y| x ^ y }.pack('C*')
  end
end
