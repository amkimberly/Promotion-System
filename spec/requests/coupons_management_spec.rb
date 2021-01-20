require 'rails_helper'

describe 'coupon management' do
  context 'show' do
    it 'render coupon json with discount' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, 
                                    coupon_quantity: 100,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'NATAL10-0001')

      get "/api/v1/coupons/#{coupon.code}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('10')
      expect(response.body).to include('22/12/2033')
    end
    it 'coupon not found' do
      get '/api/v1/coupons/ABC123'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end

    xit 'coupon with expired promotion' do
    end
  end
end