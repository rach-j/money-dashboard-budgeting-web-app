require_relative('../db/sql_runner.rb')
require_relative('./other_functions.rb')

class Merchant

  attr_reader :id, :name

  def initialize(inputs)
    @id = inputs['id'].to_i() if inputs['id']
    @name = inputs['name']
  end

  def save()
    sql = "INSERT INTO merchants
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *;"
    values =[@name]
    merchant_data = SqlRunner.run(sql, values)
    @id = merchant_data.first()['id'].to_i()
  end

  def transactions()
    sql = "SELECT transactions.* FROM transactions
    INNER JOIN transactions ON
    transactions.merchant_id = merchants.id
    WHERE merchants.id = $1
    ORDER BY transaction_date DESC;"
    values = [@id]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map {|transaction| Transaction.new(transaction)}
    return result
  end

  def total_spend()
    sql = "SELECT SUM(amount) FROM transactions
    WHERE transactions.merchant_id = $1;"
    values=[@id]
    total = to_display(SqlRunner.run(sql, values).first()['sum'].to_f())
    return total
  end

  def Merchant.all()
    sql = "SELECT * FROM merchants;"
    merchants = SqlRunner.run(sql)
    result = merchants.map {|merchant| Merchant.new(merchant)}
    return result
  end

  def Merchant.delete_all()
    sql = "DELETE FROM merchants;"
    SqlRunner.run(sql)
  end

  def Merchant.find(id)
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [id]
    merchant_data = SqlRunner.run(sql, values).first()
    result = Merchant.new(merchant_data)
    return result
  end

  def Merchant.name_exists?(name)
    sql = "SELECT * FROM merchants
    WHERE name = $1"
    values = [name]
    merchant_data = SqlRunner.run(sql, values).first()
    if merchant_data != nil
      return true
    else
      return false
    end
    return result
  end

end
