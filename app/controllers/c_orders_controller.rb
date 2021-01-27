class COrdersController < ApplicationController

  def index
    response = COrder.get_orders(params['product'])
    render json: response
  end

  def create
    response = COrder.place_market_order(params['side'], params['productId'], params['funds'])
    render json: response
  end
end
