class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]

  def index
  @recipes = Recipe.all
  end

  def show
    @ingredient = @recipe.ingredients.build
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipe_path @recipe.id
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id]).destroy
    redirect_to recipes_url
  end

  def rating
    @recipes = Recipe.rating
    render 'rating'
  end


  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :rating, :instructions, :ingredient_ids => [], ingredients_attributes: [:name])
  end

end


