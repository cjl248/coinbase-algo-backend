require 'coinbase.rb'

class Order < Coinbase

  def initialize()
    super()
  end

  # GET /orders
  #
  # status = all, open, pending, active
  # product_id = "BTC-USD", "XLM-USD", etc.
  def get_orders(status='', product_id='')
    timestamp = Time.now.utc.to_i
    method = 'GET'
    request_path = '/orders'
    body = ''
    signature = signature(request_path, body, timestamp, method)
    headers = headers(@key, signature, timestamp, @passphrase)
    return RestClient.get(@api+request_path, headers)
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

    signature = signature(request_path, body, timestamp, method)
    headers = headers(@key, signature, timestamp, @passphrase)
    return RestClient.post(@api+request_path, body.to_json, headers)
  end

  # POST /orders
  #
  # time_in_force = GTC (good til cancel), GTT, (good til time), IOC (fills what is possible and cancels rest), FOK (fill or kill - cancels if unable to match entire size)
  # cancel_after = "minutes, hours, days"
  # type = limit
  # side = buy/sell
  # product_id = "BTC-USD", "XLM-USD", etc.
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

    signature = signature(request_path, body, timestamp, method)
    headers = headers(@key, signature, timestamp, @passphrase)
    return RestClient.post(@api+request_path, body.to_json, headers)
  end

  # DELETE /orders/<id>
  # DELETE /orders/client:<client_oid>
  #
  # id = coinbase order id
  # client_oid = database created id
  def delete_order(product_id='', id)
    timestamp = Time.now.utc.to_i
    method = 'DELETE'
    request_path = "/orders/#{id}" unless product_id
    request_path = "/orders/#{id}?product_id=#{product_id}" if product_id
    body = ''

    signature = signature(request_path, body, timestamp, method)
    headers = headers(@key, signature, timestamp, @passphrase)
    return RestClient.delete(@api+request_path, headers)
  end

end
