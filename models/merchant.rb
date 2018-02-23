require_relative('../db/sql_runner.rb')

class Merchant

  attr_reader :id, :name

  def initialize(inputs)
    @id = inputs['id'].to_i() if inputs['id']
    @name = inputs['name']
  end

  def save()
    sql = "INSERT INTO merchants (
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

end
