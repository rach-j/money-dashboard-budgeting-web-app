require_relative('../db/sql_runner.rb')
require_relative('./other_functions.rb')

class Transaction

  attr_reader :id, :amount, :merchant_id, :tag_id, :transaction_date

  def initialize(inputs)
    @id = inputs['id'].to_i() if inputs['id']
    @amount = inputs['amount'].to_f()
    @merchant_id = inputs['merchant_id'].to_i()
    @tag_id = inputs['tag_id'].to_i()
    @transaction_date = inputs['transaction_date']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      amount, merchant_id, tag_id, transaction_date
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *;"
    values = [@amount, @merchant_id, @tag_id, @transaction_date]
    transaction_data = SqlRunner.run(sql, values)
    @id = transaction_data.first()['id'].to_i()
  end

  def merchant_name()
    sql = "SELECT merchants.name FROM merchants
    INNER JOIN transactions ON
    transactions.merchant_id = merchants.id
    WHERE transactions.id = $1;"
    values = [@id]
    merchant_name = SqlRunner.run(sql,values).first()['name']
    return merchant_name
  end

  def tag_name()
    sql = "SELECT tags.name FROM tags
    INNER JOIN transactions ON
    transactions.tag_id = tags.id
    WHERE transactions.id = $1;"
    values = [@id]
    tag_name = SqlRunner.run(sql, values).first()['name']
    return tag_name
  end

  def update()
    sql = "UPDATE transactions
    SET
    (
      amount, merchant_id, tag_id, transaction_date
    )
    =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5;"
    values = [@amount, @merchant_id, @tag_id, @transaction_date, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def amount_to_display
    return add_currency_sign('%.2f' % @amount)
  end

  def Transaction.all()
    sql = "SELECT * FROM transactions
    ORDER BY transaction_date DESC;"
    transactions = SqlRunner.run(sql)
    result = transactions.map {|transaction| Transaction.new(transaction)}
    return result
  end

  def Transaction.total_spend()
    sql = "SELECT SUM(amount) FROM transactions;"
    total = add_currency_sign('%.2f' % SqlRunner.run(sql).first()['sum'].to_f())
    return total
  end

  def Transaction.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def Transaction.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction_data = SqlRunner.run(sql, values).first()
    result = Transaction.new(transaction_data)
    return result
  end

  def Transaction.transactions_by_month(month_number)
    sql = "SELECT * FROM transactions
    WHERE extract (month FROM transaction_date) = $1
    ORDER BY transaction_date DESC;"
    values = [month_number]
    transactions = SqlRunner.run(sql,values)
    result = transactions.map {|transaction| Transaction.new(transaction)}
    return result
  end

  def Transaction.spending_by_month(month_number)
    sql = "SELECT sum(amount) FROM transactions
    WHERE extract (month FROM transaction_date) = $1;"
    values = [month_number]
    total = add_currency_sign('%.2f' % SqlRunner.run(sql,values).first()['sum'].to_f())
    return total
  end

end
