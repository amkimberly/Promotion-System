class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_category, only:  %i[show destroy edit update ]
  def index
    @product_categories = ProductCategory.all
  end

  def show
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.create(product_category_params)
    if @product_category.save
      redirect_to product_categories_path
      flash[:notice] = t('product_categories.flash.create')
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @product_category.update(product_category_params)
      flash[:notice] = t('product_categories.flash.update')
      redirect_to @product_category
    else
      render :edit
    end
  end

  def destroy
    @product_category.destroy
    flash[:notice] = t('product_categories.flash.delete')
    redirect_to product_categories_path
  end


  private

  def product_category_params
    params
    .require(:product_category)
    .permit(:name, :code)
  end

  def set_category
    @product_category = ProductCategory.find(params[:id])
  end

end