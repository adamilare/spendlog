class CreateCategoryTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :category_transactions do |t|
      t.references :spend_category, null: false, foreign_key: true
      t.references :spend_transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
