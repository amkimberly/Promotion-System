require 'rails_helper'

describe 'Admin removes a product category' do
  before do
    create(:product_category, name: 'Passagens Aéreas', code: 'PAX')
    user = create(:user, email: 'piupiu@locaweb.com.br', password: '123456')
    login_as user
    visit root_path
    click_on 'Categorias de produto'
    click_on 'Passagens Aéreas'
  end

  it 'from home page' do
    expect(page).to have_current_path(product_category_path(ProductCategory.last))
    expect(page).to have_link('Excluir categoria', href: product_category_path(ProductCategory.last))
  end

  it "and goes to categories' page " do
    click_on 'Excluir categoria'

    expect(page).to have_current_path(product_categories_path)
    expect(page).to have_content('Categoria removida com sucesso!')
    expect(page).not_to have_content('Passagens Aéreas')
  end
end
