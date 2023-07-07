require 'rails_helper'

RSpec.describe 'User categories index page', type: :system do
  fixtures :users, :spend_categories

  before do
    @user = users(:first_user)
    @first_category = spend_categories(:first_category)
    sign_in @user
  end

  it "displays the user's categories" do
    visit '/categories'

    expect(page).to have_content(@first_category.name)
    expect(page).to have_selector('.cat-item', count: 2)
  end
end
