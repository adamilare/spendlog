class SpendCategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_spend_category, only: %i[ show edit update destroy ]

  # GET /spend_categories or /spend_categories.json
  def index
    @spend_categories = SpendCategory.all
  end

  # GET /spend_categories/1 or /spend_categories/1.json
  def show
  end

  # GET /spend_categories/new
  def new
    @spend_category = SpendCategory.new
  end

  # GET /spend_categories/1/edit
  def edit
  end

  # POST /spend_categories or /spend_categories.json
  def create
    current_user
    @spend_category = current_user.spend_categories.build(spend_category_params)

    respond_to do |format|
      if @spend_category.save
        format.html { redirect_to spend_category_url(@spend_category), notice: "Spend category was successfully created." }
        format.json { render :show, status: :created, location: @spend_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spend_categories/1 or /spend_categories/1.json
  def update
    respond_to do |format|
      if @spend_category.update(spend_category_params)
        format.html { redirect_to spend_category_url(@spend_category), notice: "Spend category was successfully updated." }
        format.json { render :show, status: :ok, location: @spend_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spend_categories/1 or /spend_categories/1.json
  def destroy
    @spend_category.destroy

    respond_to do |format|
      format.html { redirect_to spend_categories_url, notice: "Spend category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spend_category
      @spend_category = SpendCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spend_category_params
      params.require(:spend_category).permit(:name, :icon)
    end
end
