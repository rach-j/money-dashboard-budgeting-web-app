require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require_relative('../models/other_functions.rb')

get '/bonzabudgeting/budget/:id/budgetupdate' do
  @budget = Budget.find(params['id'])
  erb(:"budget/update_budget")
end

post '/bonzabudgeting/budget/:id' do
  budget = Budget.new(params)
  budget.update()
  redirect to '/bonzabudgeting'
end
