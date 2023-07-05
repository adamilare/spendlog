# frozen_string_literal: true

class AddIconToSpendTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :spend_transactions, :icon, :string
  end
end
