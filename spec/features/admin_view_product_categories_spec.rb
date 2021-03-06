require 'rails_helper'

describe 'Admin view product categories' do
  it 'successfully' do
    ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')
    ProductCategory.create!(name: 'Hospedagem Brasil', code: 'HOSPBR')
    user = User.create!(email: 'piupiu@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de produto'

    expect(page).to have_content('Passagens Aéreas')
    expect(page).to have_content('Hospedagem Brasil')
  end

  it 'and show empty message' do
    user = User.create!(email: 'piupiu@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de produto'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  it 'and view details' do
    ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')
    ProductCategory.create!(name: 'Hospedagem Brasil', code: 'HOSPBR')
    user = User.create!(email: 'piupiu@mail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de produto'
    click_on('Passagens Aéreas')

    expect(page).to have_content('Passagens Aéreas')
    expect(page).to have_content('PAX')
  end
end
