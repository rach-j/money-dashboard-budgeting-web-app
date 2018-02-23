require_relative('../db/sql_runner.rb')

class Transaction

  attr_reader :id, :amount, :merchant_id, :tag_id

  def initialize(inputs)
    @id = inputs['id'].to_i() if inputs['id']
    @amount = inputs['amount'].to_f()
    @merchant_id = inputs['merchant_id'].to_i()
    @tag_id = inputs['tag_id'].to_i()
  end

  def save()
    sql = "INSERT INTO transactions (
    amount, merchant_id, tag_id
  )
  VALUES (
    $1, $2, $3
    )
    RETURNING *;"
    values = [@amount, @merchant_id, @tag_id]
    merchant_data = SqlRunner.run(sql, values)
    @id = merchant_data.first()['id'].to_i()
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

  def Transaction.all()
    sql = "SELECT * FROM transactions;"
    transactions = SqlRunner.run(sql)
    result = transactions.map {|transaction| Transaction.new(transaction)}
    return result
  end

  def Transaction.total_spend()
    sql = "SELECT SUM(amount) FROM transactions;"
    total = SqlRunner.run(sql).first()['sum'].to_f()
    return total
  end

  def Transaction.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end
end
