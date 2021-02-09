class PromotionsController < ApplicationController
  before_action :set_promotion, only: %i[show edit update destroy generate_coupons]

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def search
    @query = params[:query]
    @promotions = Promotion.where("name LIKE ?", "%#{@query}%")
    @coupons = Coupon.where("code LIKE ?", "%#{@query}%")
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      flash[:notice] = t('promotion.flash.create')
      redirect_to @promotion
    else
      render :new
    end
  end

  def generate_coupons
    @promotion.generate_coupons!
    redirect_to @promotion
    flash[:notice] = t('promotion.flash.generate_coupons')
  end

  def show
  end

  def edit
    render :edit
  end

  def update
    if @promotion.update(promotion_params)
      flash[:notice] = t('promotion.flash.update')
      redirect_to @promotion
    else
      render :edit
    end
  end

    def destroy
      @promotion.destroy
      flash[:notice] = t('promotion.flash.delete')
      redirect_to promotions_path
    end


  private

  def promotion_params
    params
    .require(:promotion)
    .permit(:name, :description, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            product_category_ids: [])
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end