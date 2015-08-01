require_relative 'challenge'

# Challenge 22: Crack an MT19937 seed

class Challenge22 < Challenge
  def time
    @time ||= Time.now.to_i
  end

  def generate_random_number
    # Pick a random time between now and the last 60 minutes to use as seed.
    @seed = rand(time - 3600..time)

    # Return the first random number using that seed.
    RNG::MT19937.new(@seed).extract_number
  end

  def test_crack_an_mt19937_seed
    number = generate_random_number

    result = (time - 3600..time).find do |i|
      number == RNG::MT19937.new(i).extract_number
    end

    assert_equal @seed, result
  end
end
