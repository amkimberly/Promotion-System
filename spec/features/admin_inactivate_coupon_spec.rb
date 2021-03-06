require 'rails_helper'

describe 'Admin cancels coupon' do
  it 'successfully' do
    user = User.create!(email: 'piupiu@mail.com', password: '123456')
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    promotion = Promotion.create!(name: 'Páscoa', coupon_quantity: 5,
                                  code: 'PASCOA21', discount_rate: 10,
                                  product_category_ids: 1, expiration_date: 1.day.from_now)
    coupon = Coupon.create!(promotion: promotion, code: 'NATAL10-0001')

    login_as user, scope: :user
    visit promotion_path(promotion)
    click_on 'Desabilitar cupom'

    expect(page).to have_content('Cupom desabilitado com sucesso!')
    expect(page).to have_content('NATAL10-0001 (Desabilitado)')
    expect(page).not_to have_link('Desabilitar cupom')
    expect(coupon.reload).to be_cancel
  end
end
