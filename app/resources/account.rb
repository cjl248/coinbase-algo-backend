require 'coinbase.rb'

class Account < Coinbase

  def initialize()
    super()
  end

  # GET /accounts
  #
  # id = crypto account
  # ledger = true returns ledger history for crypto id
  def get_accounts(id='', ledger=false)
    timestamp = Time.now.utc.to_i
    method = 'GET'
    request_path = "/accounts/#{id}" if ledger == false
    request_path = "/accounts/#{id}/ledger"if ledger == true
    body = ''
    sign = signature(request_path, body, timestamp, method)
    headers = headers(@key, sign, timestamp, @passphrase)
    return RestClient.get(@api+request_path, headers)
  end

end

# currency
# balance
# hold
# available
