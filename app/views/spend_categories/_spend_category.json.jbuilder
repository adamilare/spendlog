# frozen_string_literal: true

json.extract! spend_category, :id, :name, :icon, :user_id, :created_at, :updated_at
json.url spend_category_url(spend_category, format: :json)
