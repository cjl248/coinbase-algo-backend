require 'coinbase.rb'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

response = Coinbase.new

begin
  account = Coinbase.parse_response(response.get_account(ENV["BTC_ACCOUNT"], true))
  binding.pry
  account
rescue RestClient::Unauthorized, RestClient::Forbidden => err
  binding.pry
  return err.response
end
