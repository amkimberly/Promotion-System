class CouponsController < ApplicationController
  before_action :set_coupon, only: %i[cancel]

    def cancel
      @coupon.cancel!
      flash[:notice] = t('coupon.flash.cancel')
      redirect_to @coupon.promotion
    end
    
   private
   def set_coupon
    @coupon = Coupon.find(params[:id])
   end
end