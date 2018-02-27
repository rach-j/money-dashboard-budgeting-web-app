require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require_relative('../models/other_functions.rb')

get '/bonzabudgeting/spendbymonth' do
  @months = [1,2,3,4,5,6,7,8,9,10,11,12]
  @total_spend = '%.2f' % Transaction.total_spend()
  erb(:spend_breakdown_month)
end

get '/bonzabudgeting/spendbymonth/:month' do
  month_number = params['month'].to_i()
  @month = Date::MONTHNAMES[month_number]
  @total_spend_in_month = '%.2f' % Transaction.spending_by_month(month_number)
  @transactions_by_month = Transaction.transactions_by_month(month_number)
  erb(:spend_by_month)
end
