require 'rails_helper'

RSpec.describe SpendCategory, type: :model do
  fixtures :users, :spend_categories

  let(:first_user) { users(:first_user) }
  let(:second_user) { users(:second_user) }
  let(:first_category) { spend_categories(:first_category) }
  let(:second_category) { spend_categories(:second_category) }
  let(:third_category) { spend_categories(:third_category) }

  describe 'associations' do
    it 'belongs to a user' do
      expect(first_category.user).to eq(first_user)
      expect(second_category.user).to eq(first_user)
      expect(third_category.user).to eq(second_user)
    end
  end

  describe 'validations' do
    it 'requires name and icon to be present' do
      first_category.name = nil
      expect(first_category).to_not be_valid

      first_category.icon = nil
      expect(first_category).to_not be_valid
    end
  end
end
