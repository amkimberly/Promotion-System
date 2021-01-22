require 'rails_helper'

feature 'Admin registers a promotion' do
  let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

  before(:each) do
    login_as user, scope: :user
  end
  
  scenario 'from index page' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end

  scenario 'successfully' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')
    ProductCategory.create!(name: 'Restaurante', code: 'EAT20')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    check 'Hospedagem'
    check 'Passagens Aéreas'
    click_on 'Criar promoção'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Passagens Aéreas')
    expect(page).to_not have_content('Restaurante')
    expect(page).to have_link('Voltar')
  end
end
