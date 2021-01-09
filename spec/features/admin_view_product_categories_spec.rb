require 'rails_helper'

feature 'Admin view product categories' do
  scenario 'successfully' do
    ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')
    ProductCategory.create!(name: 'Hospedagem Brasil', code: 'HOSPBR')

    visit root_path
    click_on 'Categorias de produto'

    expect(page).to have_content('Passagens Aéreas')
    expect(page).to have_content('Hospedagem Brasil')
  end

  scenario 'and show empty message' do
    visit root_path
    click_on "Categorias de produto"

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and view details' do

    ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')
    ProductCategory.create!(name: 'Hospedagem Brasil', code: 'HOSPBR')
    ProductCategory.create!(name: 'Passeios Turísticos', code: 'TRAVEL')

    visit product_categories_path
    click_on('Passagens Aéreas')

    expect(page).to have_content('Passagens Aéreas')
    expect(page).to have_content('PAX')
  end
end