# frozen_string_literal: true

json.array! @spend_categories, partial: 'spend_categories/spend_category', as: :spend_category
