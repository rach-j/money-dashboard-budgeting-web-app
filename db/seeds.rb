require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('./sql_runner.rb')
require('pry-byebug')

Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()

tag1 = Tag.new({'name' => 'Groceries'})
tag2 = Tag.new({'name' => 'Clothing'})
tag3 = Tag.new({'name' => 'Entertainment'})

tag1.save()
tag2.save()
tag3.save()

merchant1 = Merchant.new({'name' => 'Tesco'})
merchant2 = Merchant.new({'name' => 'ASOS'})
merchant3 = Merchant.new({'name' => 'Odeon'})

merchant1.save()
merchant2.save()
merchant3.save()

transaction1 = Transaction.new({
  'amount' => 23.50,
  'merchant_id' => merchant1.id(),
  'tag_id' => tag1.id()
  })

transaction2 = Transaction.new({
  'amount' => 55.00,
  'merchant_id' => merchant2.id(),
  'tag_id' => tag2.id()
  })

transaction3 = Transaction.new({
  'amount' => 10.50,
  'merchant_id' => merchant3.id(),
    'tag_id' => tag3.id()
    })
transaction1.save()
transaction2.save()
transaction3.save()

binding.pry

NIL
