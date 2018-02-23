require('sinatra')
require('sinatra/contrib/all')
require_relative('models/merchant.rb')
require_relative('models/tag.rb')
require_relative('models/transaction.rb')

get '/bonzabudgeting' do
  @transactions = Transaction.all()
  @total_spend = Transaction.total_spend()
  erb(:index)
end

get '/bonzabudgeting/spendbytag/:id' do
  @tag = Tag.find(params[:id].to_i())
  @transactions_by_tag = @tag.transactions()
  @total_spend_by_tag = @tag.total_spend()
  erb(:spend_by_tag)
end
