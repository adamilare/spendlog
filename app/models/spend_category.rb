class SpendCategory < ApplicationRecord
  belongs_to :user
  has_many :category_transactions
  has_many :spend_transactions, through: :category_transactions
  has_one_attached :icon

  validates :name, :icon, presence: true

  def self.with_transaction_sum_and_count(user)
    left_outer_joins(:spend_transactions)
      .where(user:)
      .select('spend_categories.*, SUM(spend_transactions.amount) AS total_amount,
      COUNT(spend_transactions.id) AS transaction_count')
      .group('spend_categories.id')
  end
end
