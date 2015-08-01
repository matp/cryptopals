require_relative 'challenge'

# Challenge 32: Break HMAC-SHA1 with a slightly less artificial timing leak

class Challenge32 < Challenge
  PORT = 8246

  def setup
    @server = fork_webrick(Port: PORT, Logger: WEBrick::Log.new('/dev/null'),
      AccessLog: []) do |webrick|

      secret = random_word

      webrick.mount_proc '/test' do |request, response|
        filename  = request.query['filename' ]
        signature = request.query['signature']

        hmac = Cryptopals::Digest::SHA1.hmac(secret, filename).to_hex

        if filename && signature && hmac.length == signature.length
          auth = hmac.bytes.zip(signature.bytes).all? do |x, y|
            break false if x != y
            sleep(0.005)
            true
          end
        else
          auth = false
        end

        response.status = auth ? 200 : 403
        response.body = ''
      end
    end
  end

  def teardown
    Process.kill(:INT, @server)
  end

  def authenticate(filename, signature)
    begin
      params = URI.encode_www_form(filename: filename, signature: signature)
      open("http://localhost:#{PORT}/test?#{params}") { true }
    rescue OpenURI::HTTPError => e
      raise if e.io.status.first != '403'
      false
    end
  end

  def test_implement_and_break_hmac_sha1_with_an_artificial_timing_leak
    # Works reliably on my 2013 MacBook, however due to the nature of
    # timing attacks, this test may be unreliable or not work at all
    # on different hardware, depending on system load and other factors.
    #
    # The easiest way to increase reliability, at the expense of performance,
    # is to raise the sleep duration above.
    skip "This test runs 11-12 minutes and may not be completely reliable."

    signature = "0" * 40
    (0...40).each do |i|
      digit = (0...16).max_by do |digit|
        signature[i] = digit.to_s(16)

        samples = (0...20).map do
          time { authenticate('foo', signature) }
        end

        # remove the minimum and maximum sample
        samples.sort[4..-5].reduce(:+)
      end

      signature[i] = digit.to_s(16)
      p signature
    end

    assert authenticate('foo', signature)
  end
end
