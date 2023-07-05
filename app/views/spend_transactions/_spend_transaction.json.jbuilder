json.extract! spend_transaction, :id, :name, :amount, :category_id, :author_id, :created_at, :updated_at
json.url spend_transaction_url(spend_transaction, format: :json)
