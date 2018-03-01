require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require_relative('./sql_runner.rb')
require('pry-byebug')

Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()
Budget.delete_all()

tag1 = Tag.new({'name' => 'Groceries'})
tag2 = Tag.new({'name' => 'Clothing'})
tag3 = Tag.new({'name' => 'Entertainment'})
tag4 = Tag.new({'name' => 'Travel'})
tag5 = Tag.new({'name' => 'Bills'})
tag6 = Tag.new({'name' => 'Rent'})
tag7 = Tag.new({'name' => 'Socialising'})

tag1.save()
tag2.save()
tag3.save()
tag4.save()
tag5.save()
tag6.save()
tag7.save()

merchant1 = Merchant.new({'name' => 'Tesco'})
merchant2 = Merchant.new({'name' => 'ASOS'})
merchant3 = Merchant.new({'name' => 'Odeon'})

merchant1.save()
merchant2.save()
merchant3.save()

transaction1 = Transaction.new({
  'amount' => 23.50,
  'merchant_id' => merchant1.id(),
  'tag_id' => tag1.id(),
  'transaction_date' => '2018-02-11'
  })

transaction2 = Transaction.new({
  'amount' => 55.00,
  'merchant_id' => merchant2.id(),
  'tag_id' => tag2.id(),
  'transaction_date' => '2018-02-23'
  })

transaction3 = Transaction.new({
  'amount' => 10.50,
  'merchant_id' => merchant3.id(),
  'tag_id' => tag3.id(),
  'transaction_date' => '2018-01-09'
    })

transaction4 = Transaction.new({
  'amount' => 5.00,
  'merchant_id' => merchant1.id(),
  'tag_id' => tag2.id(),
  'transaction_date' => '2018-01-09'
    })

transaction5 = Transaction.new({
  'amount' => 5.00,
  'merchant_id' => merchant3.id(),
  'tag_id' => tag3.id(),
  'transaction_date' => '2018-02-11'
    })

transaction6 = Transaction.new({
  'amount' => 5.00,
  'merchant_id' => merchant2.id(),
  'tag_id' => tag2.id(),
  'transaction_date' => '2018-02-11'
    })


transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()
transaction6.save()

budget = Budget.new({'value' => 100.00})
budget.save()

binding.pry

NIL
