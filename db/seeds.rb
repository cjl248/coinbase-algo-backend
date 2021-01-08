require 'coinbase.rb'
require 'account.rb'
require 'order.rb'
require 'product.rb'

require 'price.rb'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#
#


request = Coinbase.new
account = Account.new
order = Order.new
product = Product.new

price = Price.new
price.connect




# GET /accounts
#
# begin
#   response = JSON.parse(accounts.get_account())
#   binding.pry
#   response
# rescue RestClient::Unauthorized, RestClient::Forbidden => err
#   binding.pry
#   return err.response
# end


# GET /orders
#
# begin
  # response = JSON.parse(order.get_orders())
#   binding.pry
#   response
# rescue RestClient::BadRequest => err
#   binding.pry
#   return err.response
# rescue RestClient::Unauthorized, RestClient::Forbidden => err
#   binding.pry
#   return err.response
# end


# GET /fills
#
# begin
#   response = JSON.parse(order.get_fills("BTC-USD"))
#   binding.pry
#   response
# rescue RestClient::BadRequest => err
#   binding.pry
#   return err.response
# rescue RestClient::Unauthorized, RestClient::Forbidden => err
#   binding.pry
#   return err.response
# end


# POST /orders - market_order
#
# begin
#   response = JSON.parse(
#     order.market_order('buy', 'XLM-USD', false, "0.07")
#   )
#   binding.pry
#   response
# rescue RestClient::BadRequest => err
#   binding.pry
#   return err.response
# rescue RestClient::Unauthorized, RestClient::Forbidden => err
#   binding.pry
#   return err.response
# end


# POST /orders - limit_order
#
# begin
#   response = JSON.parse(
#     order.limit_order('GTT', 'day', 'sell', 'XLM-USD', '00.30', '665')
#   )
#   binding.pry
#   response
# rescue RestClient::BadRequest => err
#   binding.pry
#   return err.response
# rescue RestClient::Unauthorized, RestClient::Forbidden => err
#   binding.pry
#   return err.response
# end


# DELETE /orders/<id>
#
# begin
#   response = JSON.parse(
#     order.delete_order('13c8672b-d5c4-4acf-86d9-c80acc0f636d')
#   )
#   binding.pry
#   response
# rescue RestClient::BadRequest => err
#   binding.pry
#   return err.response
# rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
#   binding.pry
#   return err.response
# end


# GET /products/<product-id>/ticker
#
# begin
#   response = JSON.parse(
#     product.get_ticker("BTC-USD")
#   )
#   binding.pry
#   response
# rescue RestClient::BadRequest => err
#   binding.pry
#   return err.response
# rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
#   binding.pry
#   return err.response
# end


# GET /products/<product-id>/trades
#
# begin
#   response = JSON.parse(
#     product.get_trades("BTC-USD")
#   )
#   binding.pry
#   response
# rescue RestClient::BadRequest => err
#   binding.pry
#   return err.response
# rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
#   binding.pry
#   return err.response
# end


# GET /products/<product-id>/candles
#
# begin
#   response = JSON.parse(
#     product.get_historic_rates("BTC-USD", "3600")
#   )
#   binding.pry
#   response
# rescue RestClient::BadRequest, RestClient::NotFound => err
#   binding.pry
#   return err.response
# rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
#   binding.pry
#   return err.response
# end
