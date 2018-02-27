require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require_relative('../models/other_functions.rb')

get '/bonzabudgeting/spendbymerchant/:id' do
  @merchant = Merchant.find(params['id'])
  @transactions_by_merchant = @merchant.transactions()
  @total_spend_by_merchant = add_currency_sign(@merchant.total_spend())
  # erb(:"merchant/spend_by_merchant")
  erb(:spend_by_merchant)
end

get '/bonzabudgeting/spendbymerchant' do
  @merchants = Merchant.all()
  @total_spend = add_currency_sign(Transaction.total_spend())
  erb(:spend_breakdown_merchant)
end
