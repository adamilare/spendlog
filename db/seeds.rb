# frozen_string_literal: true

first_user = User.create(name: 'Damilare Ade', email: 'mail1@gmail.com',
                         password: '123456', password_confirmation: '123456')
second_user = User.create(name: 'Ebun Ade', email: 'mail2@gmail.com',
                          password: '123456', password_confirmation: '123456')

first_category = SpendCategory.create(name: 'Transportation',
                                      icon: 'transportation.png', user: first_user)
second_category = SpendCategory.create(name: 'Groceries',
                                       icon: 'groceries.png', user: first_user)
SpendCategory.create(name: 'Fashion', icon: 'fashion.jpg', user: second_user)

first_transaction = SpendTransaction.create(author: first_user, name: 'Transaction 1',
                                            icon: 'groceries.png', amount: 200) # spend_category_ids: [1]
second_transaction = SpendTransaction.create(author: first_user, name: 'Transaction 2',
                                             icon: 'groceries.png', amount: 300) # spend_category_ids: [1,2]

CategoryTransaction.create(spend_category: first_category, spend_transaction: first_transaction)
CategoryTransaction.create(spend_category: second_category,
                           spend_transaction: first_transaction)
CategoryTransaction.create(spend_category: second_category,
                           spend_transaction: second_transaction)
