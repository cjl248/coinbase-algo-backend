class CProductsController < ApplicationController

  # URL params[product] = "USD-BTC"
  def index
    response = CProduct.get_price(params['product'])
    render json: response
  end
end
