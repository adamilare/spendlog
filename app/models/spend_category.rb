class SpendCategory < ApplicationRecord
  belongs_to :user
  has_many :category_transactions
  has_many :spend_transactions, through: :category_transactions

end
