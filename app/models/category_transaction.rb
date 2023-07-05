# frozen_string_literal: true

class CategoryTransaction < ApplicationRecord
  belongs_to :spend_category
  belongs_to :spend_transaction
end
