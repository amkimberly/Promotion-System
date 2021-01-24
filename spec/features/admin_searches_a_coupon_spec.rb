require 'rails_helper'

feature 'Admin searches a coupon' do
  scenario 'from index page' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path

    expect(page).to have_button("Buscar")
  end

  scenario 'successfully' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                 code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                 expiration_date: '22/12/2033')
    coupon = Coupon.create!(promotion: promotion, code: 'NATAL10-0001')

    login_as user, scope: :user
    visit root_path
    fill_in :query, with: 'NATAL10-0001'
    click_on 'Buscar'

    expect(page).to have_content(coupon.title)
  end

  scenario 'and coupon is not found' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                 code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                 expiration_date: '22/12/2033')

    login_as user, scope: :user
    visit promotions_path
    fill_in :query, with: 'NATAL10-0001'
    click_on 'Buscar cupom'

    expect(page).to have_content("Cupom não encontrado")
  end
end
