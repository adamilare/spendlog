require 'rails_helper'

RSpec.describe 'SpendCategory', type: :request do
  fixtures :users, :spend_categories

  before do
    @user = users(:first_user)
    @first_category = spend_categories(:first_category)
    sign_in @user
  end

  describe 'GET /categories/:id/transactions' do
    it 'should respond with success' do
      get spend_category_spend_transactions_path(@first_category)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /category' do
    it 'creates a new category' do
      data = { spend_transaction: { name: 'Transaction 3',
                                    icon: fixture_file_upload('groceries.png', 'image/png'),
                                    author_id: @user.id,
                                    amount: 10,
                                    spend_category_ids: [1] } }

      expect do
        post spend_category_spend_transactions_path(@first_category), params: data
      end.to change { SpendTransaction.count }.by(1)

      new_transaction = SpendTransaction.last

      expect(new_transaction.name).to eq(data[:spend_transaction][:name])
      expect(new_transaction.icon).to eq('groceries.png')
      expect(new_transaction.author_id).to eq(@user.id)
    end
  end
end
