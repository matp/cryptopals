require 'openssl'

module Cryptopals
  module Cipher
    class AES_128_ECB
      attr_accessor :key

      def initialize(key: String.random(16), **options)
        @key = key
      end

      [:encrypt, :decrypt].each do |method|
        define_method(method) do |string|
          perform(method) do |cipher|
            cipher.update(string) << cipher.final
          end
        end
      end

      protected

        def openssl_options
          { key: @key }
        end

        def perform(action)
          OpenSSL::Cipher.new('AES-128-ECB').tap do |cipher|
            cipher.send(action)

            openssl_options.each do |name, value|
              cipher.send("#{name}=", value) if cipher.respond_to?("#{name}=")
            end

            return yield(cipher) if block_given?
          end
        end
    end
  end
end
