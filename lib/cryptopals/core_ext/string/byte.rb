class String
  def byteslices(size)
    (0...bytesize).step(size).map {|offset| byteslice(offset, size) }
  end

  def bytetranspose(size)
    first, *rest = byteslices(size).map(&:bytes)
    first.zip(*rest).map {|slices| slices.compact.pack('C*') }
  end
end
