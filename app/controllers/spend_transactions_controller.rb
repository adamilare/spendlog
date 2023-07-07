class SpendTransactionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_spend_transaction, only: %i[show edit update destroy]

  include FileUploadHelper

  def index
    @spend_category = SpendCategory.find(params[:spend_category_id])
    @spend_transactions = current_user.spend_transactions.joins(:category_transactions)
      .where(category_transactions: { spend_category_id: @spend_category.id })
  end

  def show; end

  def new
    @spend_category = SpendCategory.find(params[:spend_category_id])
    @spend_transaction = SpendTransaction.new
    @user = current_user
    @categories = current_user.spend_categories
  end

  def edit; end

  def create
    @spend_transaction = current_user.spend_transactions.new(spend_transaction_params)

    if valid_transaction?

      respond_to do |format|
        if @spend_transaction.save
          create_category_transactions
          format.html do
            redirect_to spend_category_spend_transactions_path(params[:spend_category_id]),
                        notice: 'Spend transaction was successfully created.'
          end
        else
          reload_form
        end
      end
    else
      reload_form
    end
  end

  def update
    respond_to do |format|
      if @spend_transaction.update(spend_transaction_params)
        format.html do
          redirect_to spend_transaction_url(@spend_transaction), notice: 'Spend transaction was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @spend_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spend_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @spend_transaction.destroy

    respond_to do |format|
      format.html { redirect_to spend_transactions_url, notice: 'Spend transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def valid_transaction?
    spend_category_ids = params[:spend_transaction][:spend_category_ids]
    spend_category_ids.is_a?(Array) && spend_category_ids.any?(&:present?) &&
      spend_transaction_params[:name].present? && spend_transaction_params[:amount].present?
  end

  def create_category_transactions
    spend_category_ids = params[:spend_transaction][:spend_category_ids]
    spend_category_ids.each do |spend_category_id|
      CategoryTransaction.create(spend_category_id:, spend_transaction_id: @spend_transaction.id)
    end
  end

  def reload_form
    @categories = current_user.spend_categories
    flash.now[:alert] = 'Some fields are not set'
    render :new, status: :unprocessable_entity
  end

  def set_spend_transaction
    @spend_transaction = SpendTransaction.find(params[:id])
  rescue StandardError
    redirect_to spend_transactions_url, alert: 'The transaction is not found.'
  end

  def spend_transaction_params
    params.require(:spend_transaction).permit(:name, :amount, :icon)
  end
end
