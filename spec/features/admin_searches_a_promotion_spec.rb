require 'rails_helper'

describe 'Admin searches a promotion' do
  it 'and click on search' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit promotions_path

    expect(page).to have_button('Buscar')
  end

  it 'successfully' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                                  product_category_ids: 1, expiration_date: '22/12/2033')

    login_as user, scope: :user
    visit promotions_path
    fill_in :query, with: 'Natal'
    click_on 'Buscar'

    expect(page).to have_content(promotion.name)
  end

  it 'and promotion is not found' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit promotions_path
    fill_in :query, with: 'Natal'
    click_on 'Buscar'

    expect(page).to have_content('Nenhum resultado encontrado')
  end
end
