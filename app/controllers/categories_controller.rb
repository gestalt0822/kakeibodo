class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.all
  end

  def new
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.create(categories_params)
    redirect_to categories_path
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  def edit
  end

  def update
    @category.update(categories_params)
    redirect_to categories_path
  end

  private
    def categories_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
end
