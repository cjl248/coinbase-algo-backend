class COrdersController < ApplicationController

  def index
    response = COrder.get_orders(params['product'])
    render json: response
  end

  def create_market_order
    response = COrder.place_market_order(params['side'], params['productId'], params['funds'])
    render json: response
  end

  def create_limit_order
    response = COrder.place_limit_order(params['side'], params['productId'], params['price'], params['size'])
    render json: response
  end
end
