# frozen_string_literal: true

class SpendCategory < ApplicationRecord
  belongs_to :user
  has_many :category_transactions
  has_many :spend_transactions, through: :category_transactions

  def self.with_transaction_sum_and_count(user)
    joins(:spend_transactions)
      .where(user:)
      .select('spend_categories.*, SUM(spend_transactions.amount) AS total_amount, COUNT(spend_transactions.id) AS transaction_count')
      .group('spend_categories.id')
  end
end
