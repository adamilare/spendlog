first_user = User.create(name: 'Damilare Ade', email: "mail1@gmail.com", password: "123456", password_confirmation: "123456")
second_user = User.create(name: 'Ebun Ade', email: "mail2@gmail.com", password: "123456", password_confirmation: "123456")

first_category = SpendCategory.create(name: "Category 1", icon: "icon1", user: first_user)
second_category = SpendCategory.create(name: "Category 2", icon: "icon2", user: first_user)
third_category = SpendCategory.create(name: "Category 3", icon: "icon3", user: second_user)

first_transaction = SpendTransaction.create(author: first_user, name: 'Transaction 1', amount: 200) # spend_category_ids: [1]
second_transaction = SpendTransaction.create(author: first_user, name: 'Transaction 2', amount: 300) #spend_category_ids: [1,2]

first_cat_transaction = CategoryTransaction.create(spend_category: first_category, spend_transaction: first_transaction)
second_cat_transaction = CategoryTransaction.create(spend_category: second_category, spend_transaction: first_transaction)
third_cat_transaction = CategoryTransaction.create(spend_category: second_category, spend_transaction: second_transaction)
