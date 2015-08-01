require 'minitest/autorun'
require 'open-uri'
require 'webrick'

require 'cryptopals'

include Cryptopals

class Challenge < MiniTest::Test
  DICT = '/usr/share/dict/words'

  def time
    raise ArgumentError, 'no block given' unless block_given?
    start = Time.now
    yield
    Time.now - start
  end

  def random_word
    begin
      IO.readlines(DICT).map(&:chomp).sample
    rescue Errno::ENOENT, Errno::EACCES
      # Chosen at random from /usr/share/dict/words.
      %w[sesquibasic unpromulgated histotherapist beveil roostership hexitol
         brassard mollycoddle unmodifiably predefence Gideon peritonitic
         prattler unyearning counterferment finally columellate Ashmolean
         archiater warningly barbaric workbox afield glacialist swirl
         reconcileless diabolatry convallamarin uncarbonated unfelonious
         dilatative forebemoaned].sample
    end
  end

  def open_data_file
    return nil unless self.class.name =~ /\AChallenge(\d+)\Z/

    begin 
      # Attempt to use data file that has previously been downloaded.
      data_file_name = File.expand_path("../../data/#{$1}.txt", __FILE__)
      file = File.new(data_file_name)
    rescue
      # Open remote file.
      file = open("http://cryptopals.com/static/challenge-data/#{$1}.txt")

      # Attempt to download data file for future use.
      begin
        # Create data directory if it does not exist.
        begin
          Dir.mkdir(File.dirname(data_file_name))
        rescue Errno::EEXIST
        end

        # Download to file with temporary name.
        temp_file_name = "#{data_file_name}.#{Process.pid}.tmp"
        IO.copy_stream(file, temp_file_name)

        # Move file to final location.
        File.rename(temp_file_name, data_file_name)
      rescue
        File.unlink(temp_file_name) rescue nil
      end

      file.rewind
    end

    yield file
  ensure
    file.close if file
  end

  def fork_webrick(**options)
    readfd, writefd = IO.pipe

    pid = fork do
      # Close read end of the pipe.
      readfd.close

      # Write byte to pipe once webrick is started.
      options[:StartCallback] = lambda do
        writefd.write("\0")
        writefd.close
      end

      # Configure new webrick instance.
      server = WEBrick::HTTPServer.new(options)
      yield server if block_given?

      # Start webrick.
      trap(:INT) { server.shutdown }
      server.start
    end

    # Close write end of the pipe.
    writefd.close

    # Wait for webrick to start.
    readfd.read(1)
    readfd.close

    pid
  end
end
