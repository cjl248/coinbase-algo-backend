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

  def self.place_market_order(side, product_id, funds)
    begin
      return Order.new.market_order(side, product_id, nil, funds)
    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end

  def self.place_limit_order(side, product_id, price, size)
    begin
      return Order.new.limit_order(nil, nil, side, product_id, price, size)
    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end

end
