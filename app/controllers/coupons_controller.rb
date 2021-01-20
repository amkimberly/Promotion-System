class CouponsController < ApplicationController

    def cancel
      @coupon = Coupon.find(params[:id])
      @coupon.cancel!
      flash[:notice] = t('coupon.flash.cancel')
      redirect_to @coupon.promotion
    end
end