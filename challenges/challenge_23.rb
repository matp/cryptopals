require_relative 'challenge'

# Challenge 23: Clone an MT19937 RNG from its output

class Challenge23 < Challenge
  def test_clone_an_mt19937_rng_from_its_output
    rng = RNG::MT19937.new

    result = RNG::MT19937.new
    result.instance_variable_set(:@state,
      (0..623).map { Cryptanalysis::MT19937.untemper(rng.extract_number) })

    assert_equal (0..623).map { rng.extract_number },
      (0..623).map { result.extract_number }
  end
end
