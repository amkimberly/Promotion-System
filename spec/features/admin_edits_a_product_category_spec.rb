require 'rails_helper'

feature 'Admin edits a product category' do
  let!(:product_category) {ProductCategory.create!(name:'Passagens Aéreas', code: 'PAX') }
  let! (:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

  before (:each) do
    login_as user, scope: :user
    visit product_categories_path
    click_on "Passagens Aéreas"
  end

  scenario "from product category's page" do
    expect(page).to have_link('Editar', href: edit_product_category_path(ProductCategory.last))
  end


  scenario 'and enters edit page' do
    click_on "Editar"

    expect(current_path).to eq(edit_product_category_path(ProductCategory.last))
    expect(page).to have_field('Nome', with: 'Passagens Aéreas')
    expect(page).to have_field('Código', with: 'PAX')
  end

  scenario "and updates product categories' informations" do
    click_on "Editar"

    fill_in 'Nome', with: 'Hospedagem Brasil'
    fill_in 'Código', with: ' HOSPBR'

    click_on 'Salvar'

    expect(current_path).to eq(product_category_path(ProductCategory.last))
    expect(page).to have_content("Categoria atualizada com sucesso!")
    expect(page).to have_content('Hospedagem Brasil')
    expect(page).to have_content('HOSPBR')
  end
end