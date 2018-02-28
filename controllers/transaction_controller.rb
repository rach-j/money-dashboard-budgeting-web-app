require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require_relative('../models/other_functions.rb')

get '/bonzabudgeting/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transaction/new")
end

post '/bonzabudgeting' do
  Transaction.new(params).save()
  erb(:"transaction/create")
end

get '/bonzabudgeting/:id/edit' do
  @transaction = Transaction.find(params['id'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transaction/edit")
end

post '/bonzabudgeting/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  erb(:"transaction/update")
end

post '/bonzabudgeting/:id/delete' do
  transaction = Transaction.find(params['id'])
  transaction.delete()
  redirect to '/bonzabudgeting'
end
