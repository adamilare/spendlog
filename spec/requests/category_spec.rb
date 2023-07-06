require 'rails_helper'

RSpec.describe 'SpendCategory', type: :request do
  fixtures :users, :spend_categories

  before do
    @user = users(:first_user)
    @first_category = spend_categories(:first_category)
    sign_in @user
  end

  describe 'GET /categories' do
    it 'should respond with success' do
      get '/categories'
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get '/categories'
      expect(response).to render_template('index')
    end
  end

  describe 'GET /categories/:id' do
    it 'should respond with success' do
      get spend_category_spend_transactions_path(@first_category)
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get spend_category_spend_transactions_path(@first_category)
      expect(response).to render_template('index')
    end
  end

  describe 'POST /category' do
    it 'creates a new category' do
      data = { spend_category: { name: 'Category 3',
                                 icon: fixture_file_upload('groceries.png', 'image/png'),
                                 user_id: @user.id } }

      expect do
        post '/categories', params: data
      end.to change { SpendCategory.count }.by(1)

      new_category = SpendCategory.last

      expect(new_category.name).to eq(data[:spend_category][:name])
      expect(new_category.icon).to eq('groceries.png')
      expect(new_category.user_id).to eq(@user.id)
    end
  end
end
