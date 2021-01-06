require 'order.rb'

class COrder < ApplicationRecord
  def self.get_orders(product_id)
    begin
      return Order.new.get_orders(product_id)
    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end
end
