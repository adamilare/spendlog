class AddDefaultIconToSpendTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :spend_categories, :icon, :string, default: 'default_icon.svg'
  end
end
