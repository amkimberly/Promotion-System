require 'rails_helper'

describe 'Admin registers a valid product category' do
  before do
    user = create(:user, email: 'piupiu@mail.com', password: '123456')
    login_as user
  end

  it 'and attributes cannot be blank' do
    ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')

    visit root_path
    click_on 'Categorias de produto'
    click_on 'Registrar nova categoria'
    click_on 'Criar categoria'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and code must be unique' do
    ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')

    visit root_path
    click_on 'Categorias de produto'
    click_on 'Registrar nova categoria'
    fill_in 'Código', with: 'PAX'
    click_on 'Criar categoria'

    expect(page).to have_content('deve ser único')
  end
end
