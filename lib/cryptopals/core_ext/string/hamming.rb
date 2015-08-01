class String
  def hamming(other)
    min, max = [bytesize, other.bytesize].minmax
    bytes[0, min].zip(other.bytes[0, min])
                 .map {|x, y| (x ^ y).to_s(2).count('1') }
                 .reduce(:+)
                 .to_i + (max - min) * 8
  end
end
