require 'rails_helper'

feature 'Admin inactivate coupon' do
  scenario 'successfully' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                 code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                 expiration_date: '22/12/2033')
    coupon = Coupon.create!(promotion: promotion, code: 'HOSPBR-0001')

      login_as user, scope: :user
      visit promotion_path(promotion)
      click_on "Desabilitar cupom"

      expect(page).to have_content("Cupom desabilitado com sucesso!")
      expect(page).to have_content("HOSPBR-0001 (Desabilitado)")
      expect(page).to_not have_link("Desabilitar cupom")
      expect(coupon.reload).to be_inactive

  end
end