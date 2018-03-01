require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/budget_controller.rb')
require_relative('controllers/merchant_controller.rb')
require_relative('controllers/spend_by_dates_controller.rb')
require_relative('controllers/tag_controller.rb')
require_relative('controllers/transaction_controller.rb')

get '/bonzabudgeting' do
  @transactions = Transaction.all()
  @total_spend = Transaction.total_spend()
  @budget = Budget.all()[0]
  # Only 1 entry so fine but is there a better way?
  @budget_value = to_display(@budget.value())
  @budget_message = @budget.budget_compare(convert_back_to_num(@total_spend))
  erb(:index)
end
