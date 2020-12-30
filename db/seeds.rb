require 'coinbase.rb'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

# POST /orders
#
begin
  response = Coinbase.parse_response(
    request.market_order('buy', 'XLM-USD', false, "0.07")
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
