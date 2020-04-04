class RecipesController < ApplicationController
  before_action :set_recipes, only: [:show,:edit,:update,:destroy]
  before_action :authenticate_user!
  def index
    @recipes = Recipe.all
  end

  def show

  end

  def new
    @recipe = current_user.recipes.build
    @recipe.ingredients.build
    @recipe.directions.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      respond_to do |format|
        format.html { redirect_to @recipe, notice: 'Successfully created new recipe.' }
        format.json { render :show, status: :created, location: @recipe }
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @recipe.errors , status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    @recipe.update(recipe_params)
    if @recipe.save
      redirect_to @recipe,notice: "Successfully updated recipe"
    else
      render 'new'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: 'Successfully deleted recipe'
  end

  private
  def set_recipes
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:id,:title,:description, :image,
                                   ingredients_attributes: [:id, :name, :_destroy],
                                   directions_attributes: [:id, :step, :_destroy])
  end
end
