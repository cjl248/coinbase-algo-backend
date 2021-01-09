class CProductsController < ApplicationController

  # URL params[product] = "USD-BTC"
  def index
    response = CProduct.get_price(params['product'])
    render json: response
  end

  def show
    binding.pry
  end

  def get_bands
    response = CProduct.get_bands(params['product'], params['granularity'])
    render json: response
  end
end
