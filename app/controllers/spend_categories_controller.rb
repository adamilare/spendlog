# frozen_string_literal: true

class SpendCategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_spend_category, only: %i[show edit update destroy]

  def index
    @spend_categories = SpendCategory.with_transaction_sum_and_count(current_user)
    @spend_categories.each do |spend_category|
    end
  end

  def show; end

  def new
    @spend_category = SpendCategory.new
  end

  def edit; end

  def create
    current_user
    @spend_category = current_user.spend_categories.build(spend_category_params.except(:icon))

    attached_icon = params[:spend_category][:icon]

    if attached_icon.present?
      icon_path = Rails.root.join('app', 'assets', 'images', attached_icon.original_filename)
      File.binwrite(icon_path, attached_icon.read)
      @spend_category.icon = attached_icon.original_filename
    end

    respond_to do |format|
      if @spend_category.save
        format.html do
          redirect_to spend_category_spend_transactions_url(@spend_category),
                      notice: 'Spend category was successfully created.'
        end
        format.json { render :show, status: :created, location: @spend_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @spend_category.update(spend_category_params)
        format.html do
          redirect_to spend_category_url(@spend_category), notice: 'Spend category was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @spend_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @spend_category.destroy

    respond_to do |format|
      format.html { redirect_to spend_categories_url, notice: 'Spend category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_spend_category
    @spend_category = SpendCategory.find(params[:id])
  end

  def spend_category_params
    params.require(:spend_category).permit(:name, :icon)
  end
end
