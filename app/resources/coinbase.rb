require 'base64'
require 'openssl'
require 'json'
require 'rest-client'
require 'pry'

class Coinbase

  API = 'https://api.pro.coinbase.com'

  def initialize()
    @key = ENV['API_KEY']
    @secret = ENV['API_SECRET']
    @passphrase = ENV['PASSPHRASE']
  end

  def self.parse_response(response)
    JSON.parse(response)
  end

  def signature(request_path='', body='', timestamp=nil, method='')
    body = body.to_json if body && body.is_a?(Hash)
    timestamp = Time.now.utc.to_i if !timestamp

    message = "#{timestamp}#{method}#{request_path}#{body}"

    # create a sha256 hmac with the secret
    secret = Base64.decode64(@secret)
    hash  = OpenSSL::HMAC.digest('sha256', secret, message)
    Base64.strict_encode64(hash)
  end

  def get_account(id='', ledger=false)
    timestamp = Time.now.utc.to_i
    method = 'GET'
    request_path = "/accounts/#{id}/ledger"if ledger == true
    request_path = "/accounts/#{id}"
    body = ''
    sign = signature(request_path, body, timestamp, method)
    response = RestClient.get(
      API+request_path,
      headers=  {
        'Content-Type': 'application/json',
        'CB-ACCESS-KEY': @key,
        'CB-ACCESS-SIGN': sign,
        'CB-ACCESS-TIMESTAMP': timestamp,
        'CB-ACCESS-PASSPHRASE': @passphrase
      })
    response
  end

end
