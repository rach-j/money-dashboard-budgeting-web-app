require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/budget_controller.rb')
require_relative('controllers/merchant_controller.rb')
require_relative('controllers/spend_by_dates_controller.rb')
require_relative('controllers/tag_controller.rb')
require_relative('controllers/transaction_controller.rb')

get '/bonzabudgeting' do
  @transactions = Transaction.all()
  @total_spend = add_currency_sign(Transaction.total_spend())
  @budget = Budget.all()[0]
  # Only 1 entry so fine but is there a better way?
  @budget_value = add_currency_sign(@budget.value_to_display())
  @budget_message = @budget.budget_compare(Transaction.total_spend().to_f())
  erb(:index)
end
