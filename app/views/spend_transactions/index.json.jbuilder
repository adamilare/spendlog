# frozen_string_literal: true

json.array! @spend_transactions, partial: 'spend_transactions/spend_transaction', as: :spend_transaction
