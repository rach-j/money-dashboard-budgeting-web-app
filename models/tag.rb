require_relative('../db/sql_runner.rb')

class Tag

  attr_reader :id, :name

  def initialize(inputs)
    @id = inputs['id'].to_i() if inputs['id']
    @name = inputs['name']
  end

  def save()
    sql = "INSERT INTO tags (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *;"
    values =[@name]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data.first()['id'].to_i()
  end

  def transactions()
    sql = "SELECT transactions.* FROM transactions
    INNER JOIN tags ON
    transactions.tag_id = tags.id
    WHERE tags.id = $1;"
    values = [@id]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map {|transaction| Transaction.new(transaction)}
    return result
  end

  def total_spend()
    sql = "SELECT SUM(amount) FROM transactions
    WHERE transactions.tag_id = $1;"
    values=[@id]
    total = SqlRunner.run(sql, values).first()['sum'].to_f()
    return total
  end

  def Tag.all()
    sql = "SELECT * FROM tags;"
    tags = SqlRunner.run(sql)
    result = tags.map {|tag| Tag.new(tag)}
    return result
  end

  def Tag.delete_all()
    sql = "DELETE FROM tags;"
    SqlRunner.run(sql)
  end

  def Tag.find(id)
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    tag_data = SqlRunner.run(sql, values).first()
    result = Tag.new(tag_data)
    return result
  end
end
