class SpendTransaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_transactions
  has_many :spend_categories, through: :category_transactions
  has_one_attached :icon

  validates :name, :amount, presence: true
end
