require 'rails_helper'

RSpec.describe 'User categories index page', type: :system do
  fixtures :users, :spend_categories, :spend_transactions

  before do
    @user = users(:first_user)
    @first_category = spend_categories(:first_category)
    @first_transaction = spend_transactions(:first_transaction)
    sign_in @user
  end

  it "displays the user's categories" do
    visit spend_category_spend_transactions_path(@first_category)

    expect(page).to have_content(@first_category.name)
    expect(page).to have_selector('.cat-item', count: 1)
    expect(page).to have_content(@first_transaction.name)
  end
end
