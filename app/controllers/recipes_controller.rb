class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.recipe_products.new
  end

  # GET /recipes/1/edit
  def edit
  end

  def get_recipe_price
    recipe_id = params[:id]
    @recipe_row = Recipe.find(recipe_id.to_i)
    render json: {grand_total: @recipe_row.grand_total}
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def sort_column
      Recipe.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:recipe_product_id, :product_id, :cooking_instructions, :grand_total, recipe_products_attributes: [:id, :product_id, :product_name, :product_amount, :product_price, :product_subtotal, :_destroy])
    end
end
