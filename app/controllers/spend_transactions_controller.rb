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
  end

  def edit; end

  def create
    user = current_user
    request.referrer, flash.now[:alert] = 'No category selected' unless params[:spend_transaction][:spend_category_ids]

    @spend_transaction = user.spend_transactions.build(spend_transaction_params.except(:icon))

    params[:spend_transaction][:icon]

    @spend_transaction.icon = process_icon_upload(params[:spend_transaction][:icon])

    respond_to do |format|
      if @spend_transaction.save
        params[:spend_transaction][:spend_category_ids].each do |spend_category_id|
          CategoryTransaction.create(spend_category_id:, spend_transaction_id: @spend_transaction.id)
        end

        format.html do
          redirect_to spend_category_spend_transactions_path(params[:spend_category_id]),
                      notice: 'Spend transaction was successfully created.'
        end
        format.json { render :show, status: :created, location: @spend_transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spend_transaction.errors, status: :unprocessable_entity }
      end
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

  def set_spend_transaction
    @spend_transaction = SpendTransaction.find(params[:id])
  rescue StandardError
    redirect_to spend_transactions_url, alert: 'The transaction is not found.'
  end

  def spend_transaction_params
    params.require(:spend_transaction).permit(:name, :amount, :icon, :author_id, :spend_category_ids)
  end
end
