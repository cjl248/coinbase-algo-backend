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

  # GET /accounts
  #
  # id = crypto account
  # ledger = true returns ledger history for crypto id
  def get_account(id='', ledger=false)
    timestamp = Time.now.utc.to_i
    method = 'GET'
    request_path = "/accounts/#{id}" if ledger == false
    request_path = "/accounts/#{id}/ledger"if ledger == true
    body = ''
    sign = signature(request_path, body, timestamp, method)
    headers = headers(@key, sign, timestamp, @passphrase)
    return RestClient.get(@API+request_path, headers)
  end

  # GET /orders
  #
  # status = all, open, pending, active
  # product_id = "BTC-USD", "XLM-USD"
  def get_orders(status='', product_id='')
    timestamp = Time.now.utc.to_i
    method = 'GET'
    request_path = '/orders'
    body = ''
    sign = signature(request_path, body, timestamp, method)
    headers = headers(@key, sign, timestamp, @passphrase)
    return RestClient.get(@API+request_path, headers)
  end

  # POST /orders
  #
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
    headers = headers(@key, sign, timestamp, @passphrase)
    return RestClient.post(@API+request_path, body.to_json, headers)
  end

  # POST /orders
  #
  # time_in_force = GTC (good til cancel), GTT, (good til time), IOC (fills what is possible and cancels rest), FOK (fill or kill - cancels if unable to match entire size)
  # cancel_after = "minutes, hours, days"
  # type = limit
  # side = buy/sell
  # product_id = "BTC-USD", "XLM-USD"
  # price = price of crypto: CRYPTO/USD
  # size = amount of base currency to buy/sell
  def limit_order(time_in_force=nil, cancel_after=nil, side, product_id, price, size)
    timestamp = Time.now.utc.to_i
    method = 'POST'
    request_path = "/orders"

    body = {
      "type": "limit",
      "side": side,
      "product_id": product_id,
      "price": price,
      "size": size
    } unless !!time_in_force
    body = {
      "type": "limit",
      "side": side,
      "product_id": product_id,
      "price": price,
      "size": size,
      "time_in_force": time_in_force,
      "cancel_after": cancel_after
    } if !!time_in_force

    sign = signature(request_path, body, timestamp, method)
    headers = headers(@key, sign, timestamp, @passphrase)
    return RestClient.post(@API+request_path, body.to_json, headers)
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
