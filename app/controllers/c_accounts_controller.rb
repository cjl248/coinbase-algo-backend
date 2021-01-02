
class CAccountsController < ApplicationController
  def index
    begin
      render json: CAccount.get_accounts
    rescue RestClient::BadRequest => err
      render json: err.response
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      render json: err.response
    end
  end
end
