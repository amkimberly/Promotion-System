require 'rails_helper'

describe 'Admin generates coupons' do
  it 'with coupon quantity available' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                                  product_category_ids: 1, expiration_date: '22/12/2033')

    login_as user, scope: :user
    visit promotion_path(promotion)
    click_on 'Emitir cupons'

    expect(page).to have_current_path(promotion_path(promotion))
    expect(page).to have_content('NATAL10-0001 (Disponível)')
    expect(page).to have_content('NATAL10-0002 (Disponível)')
    expect(page).to have_content('NATAL10-0003 (Disponível)')

    expect(page).to have_content('Cupons gerados com sucesso!')
    expect(page).not_to have_link('Emitir cupons')
  end

  it 'and coupons are already generated' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                                  product_category_ids: 1, expiration_date: '22/12/2033')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    coupon = promotion.coupons.create(code: '-0001')

    login_as user, scope: :user
    visit promotion_path(promotion)

    expect(page).not_to have_link('Emitir cupons')
    expect(page).to have_content(coupon.code)
  end
end
