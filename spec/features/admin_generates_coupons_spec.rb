require 'rails_helper'

feature 'Admin generates coupons' do
  scenario 'with coupon quantity available' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    promotion = Promotion.create!(name: 'Páscoa', coupon_quantity: 5, 
                                 code: 'PASCOA21', discount_rate: 10, 
                                 expiration_date: 1.day.from_now)

    login_as user, scope: :user
    visit promotion_path(promotion)
    click_on "Emitir cupons"

    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('PASCOA21-0001')
    expect(page).to have_content('PASCOA21-0002')
    expect(page).to have_content('PASCOA21-0003')
    expect(page).to have_content("Cupons gerados com sucesso!")
    expect(page).not_to have_link('Emitir cupons')
  end
  scenario 'and coupons are already generated' do
    promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 5,
                                  discount_rate: 10, code: 'PASCOA21',
                                  expiration_date: 1.day.from_now)
    coupon = promotion.coupons.create(code: '-0001')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit promotion_path(promotion)

    expect(page).not_to have_link('Emitir cupons')
    expect(page).to have_content(coupon.code)
  end

end
