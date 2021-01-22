require 'rails_helper'

feature 'Admin searches a promotion' do
  scenario 'and click on search' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit promotions_path

    expect(page).to have_button("Pesquisar")
  end
  scenario 'successfully' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                 code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                 expiration_date: '22/12/2033')

    login_as user, scope: :user
    visit promotions_path
    fill_in 'Buscar promoção', with: 'Natal'
    click_on 'Pesquisar'

    expect(page).to have_content(promotion.name)
  end
  scenario 'and promotion is not found' do
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit promotions_path
    fill_in 'Buscar promoção', with: 'Natal'
    click_on 'Pesquisar'

    expect(page).to have_content('Promoção não encontrada')
  end
end