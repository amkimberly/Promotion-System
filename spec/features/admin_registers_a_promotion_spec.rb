require 'rails_helper'

describe 'Admin registers a promotion' do
  before do
    user = create(:user, email: 'piupiu@mail.com', password: '123456')
    login_as user
  end

  it 'from index page' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end

  it 'successfully' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')

    visit new_promotion_path
    fill_in 'Título', with: 'Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    check 'Hospedagem'
    click_on 'Criar promoção'

    expect(page).to have_current_path(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('90')
    expect(page).to have_content('Hospedagem')
    expect(page).to have_link('Voltar')
  end
end
