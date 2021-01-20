#Api::V1::CouponsController
#end

module Api 
  module V1 
    class CouponsController < ApiController
      def show
        @coupon = Coupon.find_by!(code: params[:code])
        render json: @coupon, status: :ok

      rescue ActiveRecord::RecordNotFound
        render json: 'Cupom não encontrado', status: :not_found
      end
    end
  end
end