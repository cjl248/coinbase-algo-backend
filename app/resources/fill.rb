require 'coinbase.rb'

class Fill < Coinbase

  def initialize()
    super()
  end

  # GET /fills
  # order_id
  # product_id = "BTC-USD", "ALGO-USD", etc.

  def get_fills(product_id=nil, order_id=nil)
    timestamp = Time.now.utc.to_i
    method = 'GET'
    request_path = '/fills' unless product_id || order_id
    request_path = "/fills?product_id=#{product_id}" if product_id
    request_path = "/fills?order_id=#{order_id}" if order_id
    body =''
    signature = signature(request_path, body, timestamp, method)
    headers = headers(@key, signature, timestamp, @passphrase)
    return RestClient.get(@api+request_path, headers)
  end

end
