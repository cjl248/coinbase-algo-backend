require 'coinbase.rb'

class Product < Coinbase

  def initialize
    super()
  end

  # GET /products
  # returns the list of products available
  def get_product_list
    request_path = "/products"
    return RestClient.get(@api+request_path)
  end

  # GET /products/<product-id>/ticker
  #
  # product_id = "BTC-USD", "XLM-USD"
  def get_ticker(product_id)
    request_path = "/products/#{product_id}/ticker"
    return RestClient.get(@api+request_path)
  end

  # GET /products/<product-id>/trades
  #
  # product_id = "BTC-USD", "XLM-USD"
  def get_trades(product_id)
    request_path = "/products/#{product_id}/trades"
    return RestClient.get(@api+request_path)
  end

  # GET /products/<product-id>/candles
  # returns the last 300 intervals
  #
  # product_id = "BTC-USD", "XLM-USD"
  # granularity = 86400(1d), 21600(6hrs), 3600(1hr)
  # returns [ time, low, high, open, close, volume ]
  def get_historic_rates(product_id, granularity)
    request_path = "/products/#{product_id}/candles?granularity=#{granularity}"
    return RestClient.get(@api+request_path)
  end

  # GET /products/<product-id>/stats
  # returns [open, high, low, volume, last, volume_30day]
  def get_stats(product_id)
    request_path = "/products/#{product_id}/stats"
    return RestClient.get(@api+request_path)
  end

end
