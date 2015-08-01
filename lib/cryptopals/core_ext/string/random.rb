require 'securerandom'

class String
  class << self
    def random(size)
      size = rand(size) if size.is_a?(Range)
      SecureRandom.random_bytes(size)
    end
  end
end
