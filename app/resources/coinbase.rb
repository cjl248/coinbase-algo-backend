require 'base64'
require 'openssl'
require 'json'
require 'rest-client'
require 'pry'

class Coinbase

  def initialize()
    @API = 'https://api.pro.coinbase.com'
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
    request_path = "/accounts/#{id}" if ledger == false
    request_path = "/accounts/#{id}/ledger"if ledger == true
    body = ''
    sign = signature(request_path, body, timestamp, method)
    response = RestClient.get(
      @API+request_path,
      headers =  {
        'Content-Type': 'application/json',
        'CB-ACCESS-KEY': @key,
        'CB-ACCESS-SIGN': sign,
        'CB-ACCESS-TIMESTAMP': timestamp,
        'CB-ACCESS-PASSPHRASE': @passphrase
      })
    response
  end

  # side = buy/sell
  # product_id="BTC-USD", "XLM-USD"
  # size[optional] = desired ammount in base currency (BTC)
  # funds[optional] = desired ammount of quote currency ($)
  def market_order(side, product_id, size, funds)

    timestamp = Time.now.utc.to_i
    method = 'POST'
    request_path = "/orders"

    body = {
      "type": "market",
      "side": side,
      "size": size,
      "product_id": product_id
    } if !!size
    body = {
      "type": "market",
      "side":  side,
      "funds": funds,
      "product_id": product_id
    } if !!funds

    sign = signature(request_path, body, timestamp, method)

    headers = {
      'Content-Type': 'application/json',
      'CB-ACCESS-KEY': @key,
      'CB-ACCESS-SIGN': sign,
      'CB-ACCESS-TIMESTAMP': timestamp,
      'CB-ACCESS-PASSPHRASE': @passphrase
    }
    
    response = RestClient.post(
      @API+request_path,
      body.to_json,
      headers
    )

    response
  end

  # side = buy/sell
  # product_id="BTC-USD", "XLM-USD"
  def limit_order(type='limit', side, product_id, price, size)
    timestamp = Time.now.utc.to_i
    method = 'POST'
    request_path = "/orders"
  end

end
