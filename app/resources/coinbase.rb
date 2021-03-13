require 'base64'
require 'openssl'
require 'json'
require 'rest-client'

class Coinbase

  def initialize()
    @api = 'https://api.pro.coinbase.com'
    @key = ENV['API_KEY']
    @secret = ENV['API_SECRET']
    @passphrase = ENV['PASSPHRASE']
  end

  def self.stringify(response)
    response.to_s
  end


  private

  def signature(request_path='', body='', timestamp=nil, method='')
    body = body.to_json if body && body.is_a?(Hash)
    timestamp = Time.now.utc.to_i if !timestamp
    message = "#{timestamp}#{method}#{request_path}#{body}"
    # create a sha256 hmac with the secret
    secret = Base64.decode64(@secret)
    hash  = OpenSSL::HMAC.digest('sha256', secret, message)
    Base64.strict_encode64(hash)
  end

  def headers(key, signature, timestamp, passphrase)
    return {
      'Content-Type': 'application/json',
      'CB-ACCESS-KEY': key,
      'CB-ACCESS-SIGN': signature,
      'CB-ACCESS-TIMESTAMP': timestamp,
      'CB-ACCESS-PASSPHRASE': passphrase
    }
  end

end
