require 'coinbase.rb'
require 'account.rb'

class CAccount < ApplicationRecord

  def self.get_accounts
    begin
      return Account.new.get_accounts
    rescue RestClient::BadRequest => err
      return err.response
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      return err.response
    end
  end

end
