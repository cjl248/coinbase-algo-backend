require 'coinbase.rb'
require 'account.rb'
require 'order.rb'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#
#


# request = Coinbase.new
# account = Account.new
# order = Order.new


# GET /accounts
#
# begin
#   response = Coinbase.parse_response(
#     account.get_account()
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
#     order.get_orders()
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
#   response = Coinbase.parse_response(
#     order.limit_order('GTT', 'day', 'buy', 'XLM-USD', '00.1275', '590')
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
#   response = Coinbase.parse_response(
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
