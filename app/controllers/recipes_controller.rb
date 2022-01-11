class RecipesController < ApplicationController

  before_action :set_recipe, only: %i[ show edit update destroy ]


  def get_recipe_info
    @recipe_product_data = Product.where("id = ?", params[:id]).first
    price_per_kg = Product.where("id = ? ((SUM(purchase_price*remaining_quantity))/(SUM(remaining_quantity)))/(grams_per_unit/1000) AS price_per_kg
                    FROM products
                      LEFT OUTER JOIN purchase_products ON products.id = purchase_products.product_id
                      LEFT OUTER JOIN inventories ON products.id = inventories.product_id
                    GROUP BY products.id")
    render json: {price_per_kg: @recipe_product_data.price_per_kg, unit: @recipe_product_data.unit  }
  end

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
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit( :id, :recipe_name, :recipe_cost, :yield, :instructions,
        recipe_products_attributes: [ :product_id, :amount, :ingredient_total],)
    end

    def sort_column
      params[:sort] || "created_at"
     end
     
     def sort_direction
       params[:direction] || "asc"
     end 
end

