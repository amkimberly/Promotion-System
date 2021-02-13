require 'rails_helper'

describe 'Admin view promotions' do
  it 'successfully' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                      product_category_ids: 1, expiration_date: '22/12/2033')
    user = create(:user, email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
  end

  it 'and view details' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      product_category_ids: 1, expiration_date: '22/12/2033')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit promotions_path
    click_on 'Cyber Monday'

    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
  end

  it 'and no promotion are created' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Nenhuma promoção cadastrada')
  end

  it 'and return to home page' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                      product_category_ids: 1, expiration_date: '22/12/2033')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar'

    expect(page).to have_current_path(root_path)
  end

  it 'and return to promotions page' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                      product_category_ids: 1, expiration_date: '22/12/2033')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Voltar'

    expect(page).to have_current_path(promotions_path)
  end
end
