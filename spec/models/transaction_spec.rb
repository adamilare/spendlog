require 'rails_helper'

RSpec.describe SpendTransaction, type: :model do
  fixtures :users, :spend_categories, :spend_transactions, :category_transactions

  let(:first_user) { users(:first_user) }
  let(:second_user) { users(:second_user) }

  let(:first_category) { spend_categories(:first_category) }
  let(:second_category) { spend_categories(:second_category) }
  let(:third_category) { spend_categories(:third_category) }

  let(:first_transaction) { spend_transactions(:first_transaction) }
  let(:second_transaction) { spend_transactions(:second_transaction) }

  let(:first_cat_trxn) { category_transactions(:first_cat_trxn) }
  let(:second_cat_trxn) { category_transactions(:second_cat_trxn) }

  describe 'associations user to category' do
    it 'belongs to a user' do
      expect(first_transaction.author).to eq(first_user)
      expect(second_transaction.author).to eq(first_user)
    end
  end

  describe 'associations transaction to category' do
    it 'belongs to a user' do
      expect(first_cat_trxn.spend_category).to eq(first_category)
      expect(first_cat_trxn.spend_transaction).to eq(first_transaction)

      expect(second_cat_trxn.spend_category).to eq(second_category)
      expect(second_cat_trxn.spend_transaction).to eq(first_transaction)
    end
  end

  # describe 'associations transaction to category 2' do
  #   it 'belongs to a user' do
  #     expect(first_cat_trxn.spend_category).to eq(first_category)
  #     expect(first_cat_trxn.spend_transaction).to eq(first_transaction)

  #     expect(second_cat_trxn.spend_category).to eq(second_category)
  #     expect(second_cat_trxn.spend_category).to eq(first_transaction)
  #   end
  # end

  describe 'validations' do
    it 'requires name and icon to be present' do
      first_transaction.name = nil
      expect(first_transaction).to_not be_valid

      first_transaction.icon = nil
      expect(first_transaction).to_not be_valid
    end
  end
end
