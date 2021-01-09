class ProductCategoriesController < ApplicationController

  def index
    @product_categories = ProductCategory.all
  end

  def show
    @product_category = ProductCategory.find(params[:id])
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.create(product_category_params)
    if @product_category.save
      redirect_to product_categories_path
    else
      render :new
    end
  end


  private

  def product_category_params
    params
    .require(:product_category)
    .permit(:name, :code)
  end

end