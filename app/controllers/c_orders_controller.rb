class COrdersController < ApplicationController

  def index
    response = COrder.get_orders(params['product'])
    render json: response
  end
end