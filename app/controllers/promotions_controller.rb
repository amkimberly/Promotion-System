class PromotionsController < ApplicationController

  before_action :set_promotion, only: %i[show edit update destroy]

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.create(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def show
  end

  def edit
    render :edit
  end

  def update
    if @promotion.update(promotion_params)
      flash[:notice] = "Promoção atualizada com sucesso!"
      redirect_to @promotion
    else
      render_ :edit
    end
  end


  private

  def promotion_params
    params
    .require(:promotion)
    .permit(:name, :description, :code, :discount_rate,
            :coupon_quantity, :expiration_date)
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end