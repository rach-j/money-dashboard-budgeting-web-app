require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require_relative('../models/other_functions.rb')

get '/bonzabudgeting/spendbytag/:id' do
  @tag = Tag.find(params['id'])
  @transactions_by_tag = @tag.transactions()
  @total_spend_by_tag = @tag.total_spend()
  erb(:"tag/spend_by_tag")
end

get '/bonzabudgeting/spendbytag' do
  @tags = Tag.all()
  @total_spend = Transaction.total_spend()
  erb(:"tag/spend_breakdown_tag")
end
