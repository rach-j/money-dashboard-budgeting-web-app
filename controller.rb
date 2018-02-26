require('sinatra')
require('sinatra/contrib/all')
require_relative('models/merchant.rb')
require_relative('models/tag.rb')
require_relative('models/transaction.rb')
require_relative('models/budget.rb')

get '/bonzabudgeting' do
  @transactions = Transaction.all()
  @total_spend = '%.2f' % Transaction.total_spend()
  @budget = Budget.all()[0]
  # Only 1 entry so fine but is there a better way?
  @budget_value = '%.2f' % @budget.value()
  @budget_message = @budget.budget_compare(Transaction.total_spend())
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

get '/bonzabudgeting/spendbymerchant/:id' do
    @merchant = Merchant.find(params[:id].to_i())
    @transactions_by_merchant = @merchant.transactions()
    @total_spend_by_merchant = '%.2f' % @merchant.total_spend()
    erb(:spend_by_merchant)
end

get '/bonzabudgeting/spendbymerchant' do
  @merchants = Merchant.all()
  @total_spend = '%.2f' % Transaction.total_spend()
  erb(:spend_breakdown_merchant)
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

get '/bonzabudgeting/:id/edit' do
  @transaction = Transaction.find(params['id'])
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:edit)
end

post '/bonzabudgeting/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  erb(:update)
end

post '/bonzabudgeting/:id/delete' do
  transaction = Transaction.find(params['id'])
  transaction.delete()
  redirect to '/bonzabudgeting'
end

get '/bonzabudgeting/budget/:id/budgetupdate' do
  @budget = Budget.find(params['id'])
  erb(:update_budget)
end

post '/bonzabudgeting/budget/:id' do
  budget = Budget.new(params)
  budget.update()
  redirect to '/bonzabudgeting'
end
