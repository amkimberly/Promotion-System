require 'rails_helper'

describe 'Admin registers a valid promotion' do
  before do
    user = create(:user, email: 'piupiu@mail.com', password: '123456')
    login_as user
  end

  it 'and attributes cannot be blank' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      product_category_ids: 1, expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    click_on 'Criar promoção'

    expect(page).to have_content('não pode ficar em branco', count: 5)
    expect(page).to have_content('precisa ser selecionada')
  end

  it 'and code must be unique' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      product_category_ids: 1, expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar promoção'

    expect(page).to have_content('deve ser único')
  end
end
