class RecipesController < ApplicationController

  before_action :set_recipe, only: %i[ show edit update destroy ]

  def get_production_info
      @recipe_cost = Recipe.get_recipe_cost(params[:id].to_i).first
      render json: {recipe_cost: @recipe_cost["usage_cost"], units: @recipe_cost["units"], yield: @recipe_cost["yield"], 
      product_id: @recipe_cost["product_id"] }
  end 
  
  #get ingredient amounts for modal in "create new production"
  def get_usage_info 
    @usage_info = Recipe.get_usage_info(params[:id].to_i).first
    render json: {product_name: @usage_info["product_name"], usage_amount: @usage_info["usage_amount_kg"] }
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
      params.require(:recipe).permit( :id, :product_id, :recipe_cost, :yield, :instructions, :units, :recipe_name,
        recipe_products_attributes: [ :id, :product_id, :recipe_id, :cost_per_kg, :amount, :ingredient_total, :_destroy ])
        
    end

    def sort_column
      params[:sort] || "created_at"
     end
     
     def sort_direction
       params[:direction] || "asc"
     end 
end

