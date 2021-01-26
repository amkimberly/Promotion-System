require 'rails_helper'

describe 'coupon management' do
  context 'show' do
    it 'render coupon json with discount' do
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                    product_category_ids: 1, expiration_date: '22/12/2033')
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

    #TODO: Make this test pass
    xit 'coupon with expired promotion' do
    end
  end
  context 'inactivate' do
    it 'change coupon status' do
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                    product_category_ids: 1, expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'NATAL10-0001')

      post "/api/v1/coupons/#{coupon.code}/inactivate", params: {order: {code: 'ORDER123'}}

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom utilizado com sucesso')
      expect(coupon.reload).to be_inactive
      expect(coupon.reload.order).to eq('ORDER123') 
    end

    xit 'coupon not found by code' do
      
    end

    it 'order must exist' do
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                    product_category_ids: 1, expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'NATAL10-0001')

      post "/api/v1/coupons/#{coupon.code}/inactivate", params: {order: {code: ''}}

      expect(response).to have_http_status(422)
    end

    it 'order must exist' do
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                    product_category_ids: 1, expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/inactivate", params: {}

      expect(response).to have_http_status(412)
    end
  end
end