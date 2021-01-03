require 'product.rb'

class CProduct < ApplicationRecord

  # GET /products/<product-id>/ticker
  def self.get_price(product_id)
    begin
      return Product.new.get_ticker(product_id)
    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end

end
