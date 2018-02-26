def budget_compare(budget, spend)
  if budget > spend
    amount_over = '%.2f' % (budget - spend)
    return "You are #{amount_over} budget!"
  else
    amount_under = '%.2f' % (spend - budget)
    return "Keep saving those pennies, you're #{amount_under} under budget!"
  end
end
