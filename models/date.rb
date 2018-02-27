# require_relative('../db/sql_runner')
#
# class TransactionDate
#
#   attr_reader :id, :transaction_date
#
#   def initialize(inputs)
#     @id = inputs['id'].to_i() if inputs['id']
#     @transaction_date = inputs['transaction_date']
#   end
#
#   def save()
#     sql = "INSERT INTO dates (
#     transaction_date
#     )
#     VALUES
#     (
#     $1
#     )
#     RETURNING *;"
#     values =[@transaction_date]
#     date_data = SqlRunner.run(sql, values)
#     @id = date_data.first()['id'].to_i()
#   end
#
#   def TransactionDate.delete_all()
#     sql = "DELETE FROM dates;"
#     SqlRunner.run(sql)
#   end
# 
# end
