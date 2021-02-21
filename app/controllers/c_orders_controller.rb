class COrdersController < ApplicationController

  def index
    response = COrder.get_orders(params['product'])
    render json: response
  end

  def create_market_order
    if params['pin'] === ENV['PIN']
      response = COrder.place_market_order(params['side'], params['productId'], params['funds'])
      render json: response
    else
      render json: { message: 'Incorrect pin' }
    end
  end

  def create_limit_order
    if params['pin'] === ENV['PIN']
      response = COrder.place_limit_order(params['side'], params['productId'], params['price'], params['size'])
      render json: response
    else
      render json: { message: 'Incorrect pin' }
    end
  end
end
