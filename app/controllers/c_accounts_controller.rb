
class CAccountsController < ApplicationController
  def index
    render json: CAccount.get_accounts
  end
end
