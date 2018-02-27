require_relative('../db/sql_runner')

class Budget

  attr_reader :id, :value

  def initialize(inputs)
    @id = inputs['id'].to_i() if inputs['id']
    @value = inputs['value'].to_f()
  end

  def save()
    sql = "INSERT INTO budgets
    (
      value
    )
    VALUES
    (
      $1
    )
    RETURNING *;"
    values = [@value]
    budget_data = SqlRunner.run(sql, values)
    @id = budget_data.first()['id'].to_i()
  end

  def budget_compare(spend)
    budget = @value
    if spend > budget
      amount_over = '%.2f' % (spend - budget)
      return "You are £#{amount_over} over budget! Beans on toast for the rest of the week?"
    else
      amount_under = '%.2f' % (budget - spend)
      return "Keep saving those pennies, you're £#{amount_under} under budget!"
    end
  end

  def update()
    sql = "UPDATE budgets
    SET
      value
    =
      $1
    WHERE id = $2;"
    values = [@value, @id]
    SqlRunner.run(sql, values)
  end


  def Budget.delete_all()
    sql = "DELETE FROM budgets;"
    SqlRunner.run(sql)
  end

  def Budget.all()
    sql = "SELECT * FROM budgets;"
    budgets = SqlRunner.run(sql)
    result = budgets.map {|budget| Budget.new(budget)}
    return result
  end

  def Budget.find(id)
    sql = "SELECT * FROM budgets
    WHERE id = $1;"
    values = [id]
    budget_data = SqlRunner.run(sql, values).first()
    result = Budget.new(budget_data)
    return result
  end

end
