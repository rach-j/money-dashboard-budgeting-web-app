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
  @total_spend_by_merchant = @merchant.total_spend()
  erb(:"merchant/index")
end

get '/bonzabudgeting/spendbymerchant' do
  @merchants = Merchant.all()
  @total_spend = Transaction.total_spend()
  erb(:"merchant/breakdown_by_merchant")
end

get '/bonzabudgeting/newmerchant' do
  erb(:"merchant/new")
end

get '/bonzabudgeting/newmerchantexists' do
  erb(:"merchant/merchant_exists_message")
end

post '/bonzabudgeting/merchants' do
  redirect to '/bonzabudgeting/newmerchantexists' if Merchant.name_exists?(params['name'])
  Merchant.new(params).save()
  erb(:"merchant/new_merchant_message")
end
