require 'rails_helper'

feature 'Admin removes a product category' do
  #ARRANGE
  let!(:product_category) {ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')}
  let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

  #ACTION
  before(:each) do
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de produto'
    click_on 'Passagens Aéreas'
  end

  scenario 'from home page' do
    #ASSERT
    expect(current_path).to eq(product_category_path(ProductCategory.last))
    expect(page).to have_link('Excluir categoria', href: product_category_path(ProductCategory.last))
  end

  scenario "and goes to categories' page " do
    #ACTION
    click_on 'Excluir categoria'
    #ASSERT
    expect(current_path).to eq(product_categories_path)
    expect(page).to have_content('Categoria removida com sucesso!')
    expect(page).to_not have_content('Passagens Aéreas')
  end
end