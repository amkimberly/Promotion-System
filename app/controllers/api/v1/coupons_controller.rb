# Api::V1::CouponsController
# end

module Api
  module V1
    class CouponsController < ApiController
      before_action :verify_order_code, only: %i[inactivate]
      def show
        @coupon = Coupon.find_by!(code: params[:code])
        render json: @coupon, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: I18n.t('coupons.message.not_found'), status: :not_found
      end

      def inactivate
        @coupon = Coupon.find_by!(code: params[:code])
        @coupon.inactivate!(params[:order][:code])
        render json: I18n.t('coupons.message.used'), status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: '', status: :unprocessable_entity
      end

      private

      def verify_order_code
        return if params.dig(:order, :code)

        render json: '', status: :precondition_failed
      end
    end
  end
end
