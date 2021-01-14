class CouponsController < ApplicationController

    def disable
      @coupon = Coupon.find(params[:id])
      flash[:notice] = "Cupom desabilitado com sucesso!"
      redirect_to @coupon.promotion
    end
end