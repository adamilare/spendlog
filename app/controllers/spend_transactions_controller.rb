class SpendTransactionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_spend_transaction, only: %i[ show edit update destroy ]

  # GET /spend_transactions or /spend_transactions.json
  def index
    @spend_transactions = SpendTransaction.all
  end

  # GET /spend_transactions/1 or /spend_transactions/1.json
  def show
    puts '------------- show show'
    # set_spend_transaction
  end

  # GET /spend_transactions/new
  def new
    @spend_transaction = SpendTransaction.new
    @user = current_user
  end

  # GET /spend_transactions/1/edit
  def edit
  end

  # POST /spend_transactions or /spend_transactions.json
  def create
    user = current_user
    @spend_transaction = user.spend_transactions.build(spend_transaction_params)

    respond_to do |format|
      if @spend_transaction.save
        params[:spend_transaction][:spend_category_ids].each do |spend_category_id|
          CategoryTransaction.create(spend_category_id: spend_category_id, spend_transaction_id: @spend_transaction.id)
        end
      
        format.html { redirect_to spend_transaction_url(@spend_transaction), notice: "Spend transaction was successfully created." }
        format.json { render :show, status: :created, location: @spend_transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spend_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spend_transactions/1 or /spend_transactions/1.json
  def update
    respond_to do |format|
      if @spend_transaction.update(spend_transaction_params)
        format.html { redirect_to spend_transaction_url(@spend_transaction), notice: "Spend transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @spend_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spend_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spend_transactions/1 or /spend_transactions/1.json
  def destroy
    @spend_transaction.destroy

    respond_to do |format|
      format.html { redirect_to spend_transactions_url, notice: "Spend transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spend_transaction
      puts '------------set before'
      begin
        @spend_transaction = SpendTransaction.find(params[:id])
        p '-------------set after', @spend_transaction
      rescue => exception
        puts ' rescued -------------------------------'
        redirect_to spend_transactions_url, alert: "The transaction is not found."
      end
    end

    # Only allow a list of trusted parameters through.
    def spend_transaction_params
      params.require(:spend_transaction).permit(:name, :amount, :author_id, :spend_category_ids)
    end
end
