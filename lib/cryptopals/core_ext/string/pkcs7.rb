class String
  def pkcs7_pad(size)
    length = size - bytesize % size
    bytes.pack('C*') + length.chr * length
  end

  def pkcs7_unpad
    padding  = byteslice(-1)
    padding *= padding.ord if padding

    unless padding && !padding.empty? && end_with?(padding)
      raise ArgumentError, 'invalid pkcs7 padding'
    end

    self[0..-(padding.length + 1)]
  end
end
