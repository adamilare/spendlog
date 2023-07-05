ActiveRecord::Schema[7.0].define(version: 20_230_704_162_120) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'category_transactions', force: :cascade do |t|
    t.bigint 'spend_category_id', null: false
    t.bigint 'spend_transaction_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['spend_category_id'], name: 'index_category_transactions_on_spend_category_id'
    t.index ['spend_transaction_id'], name: 'index_category_transactions_on_spend_transaction_id'
  end

  create_table 'spend_categories', force: :cascade do |t|
    t.string 'name'
    t.string 'icon'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_spend_categories_on_user_id'
  end

  create_table 'spend_transactions', force: :cascade do |t|
    t.string 'name'
    t.decimal 'amount'
    t.bigint 'author_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'icon'
    t.index ['author_id'], name: 'index_spend_transactions_on_author_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'category_transactions', 'spend_categories'
  add_foreign_key 'category_transactions', 'spend_transactions'
  add_foreign_key 'spend_categories', 'users'
  add_foreign_key 'spend_transactions', 'users', column: 'author_id'
end
