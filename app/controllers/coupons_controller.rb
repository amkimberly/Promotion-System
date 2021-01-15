class CouponsController < ApplicationController

    def inactivate
      @coupon = Coupon.find(params[:id])
      @coupon.inactive!
      flash[:notice] = t('coupon.flash.inactivate')
      redirect_to @coupon.promotion
    end
end