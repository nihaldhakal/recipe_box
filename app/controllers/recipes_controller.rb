class RecipesController < ApplicationController
  before_action :set_recipes, only: [:show,:edit,:update,:destroy]
  def index
    @recipes = Recipe.all
  end

  def show

  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Successfully created new recipe"
    else
      render 'new'
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
    params.require(:recipe).permit(:title,:description, :image,
                                   ingredients_attributes: [:id, :name, :_destroy],
                                   descriptions_attributes: [:id, :step, :_destroy])
  end
end
