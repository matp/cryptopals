require 'base64'

class String
  class << self
    def from_base64(string)
      Base64.strict_decode64(string)
    end
  end

  def to_base64
    Base64.strict_encode64(self)
  end
end
