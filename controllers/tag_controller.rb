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
  erb(:"tag/index")
end

get '/bonzabudgeting/spendbytag' do
  @tags = Tag.all()
  @total_spend = Transaction.total_spend()
  erb(:"tag/breakdown_by_tag")
end

get '/bonzabudgeting/newtag' do
  erb(:"tag/new")
end

get '/bonzabudgeting/newtagexists' do
  erb(:"tag/tag_exists_message")
end

post '/bonzabudgeting/tags' do
  redirect to '/bonzabudgeting/newtagexists' if Tag.name_exists?(params['name'])
  Tag.new(params).save()
  erb(:"tag/new_tag_message")
end
