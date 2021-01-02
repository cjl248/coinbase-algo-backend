require 'coinbase.rb'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#
#


request = Coinbase.new


# GET /accounts
#
# begin
#   response = Coinbase.parse_response(
#     request.get_account(ENV["BTC_ACCOUNT"], false)
#   )
#   binding.pry
#   response
# rescue RestClient::Unauthorized, RestClient::Forbidden => err
#   binding.pry
#   return err.response
# end


# GET /orders
#
# begin
#   response = Coinbase.parse_response(
#     request.get_orders()
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


# POST /orders - market_order
#
# begin
#   response = Coinbase.parse_response(
#     request.market_order('buy', 'XLM-USD', false, "0.07")
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
begin
  response = Coinbase.parse_response(
    request.limit_order('GTT', 'day', 'buy', 'BTC-USD', '31250.00', '0.00238001')
  )
  binding.pry
  response
rescue RestClient::BadRequest => err
  binding.pry
  return err.response
rescue RestClient::Unauthorized, RestClient::Forbidden => err
  binding.pry
  return err.response
end
