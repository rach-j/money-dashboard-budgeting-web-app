require('sinatra')
require('sinatra/contrib/all')
require_relative('models/merchant.rb')
require_relative('models/tag.rb')
require_relative('models/transaction.rb')

get '/bonzabudgeting' do
  @transactions = Transaction.all()
  @total_spend = '%.2f' % Transaction.total_spend()
  erb(:index)
end

get '/bonzabudgeting/spendbytag/:id' do
  @tag = Tag.find(params[:id].to_i())
  @transactions_by_tag = @tag.transactions()
  @total_spend_by_tag = '%.2f' % @tag.total_spend()
  erb(:spend_by_tag)
end

get '/bonzabudgeting/spendbytag' do
  @tags = Tag.all()
  @total_spend = '%.2f' % Transaction.total_spend()
  erb(:spend_breakdown_tag)
end

get '/bonzabudgeting/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:new)
end

post '/bonzabudgeting' do
  Transaction.new(params).save()
  erb(:create)
end
