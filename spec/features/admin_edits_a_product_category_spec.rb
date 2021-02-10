require 'rails_helper'

describe 'Admin edits a product category' do
  before do
    user = create(:user)
    login_as(user)
  end

  context 'when enters product categories page' do
    it 'and see edit link' do
      create(:product_category, name: 'Passagens Aéreas', code: 'PAX')

      visit product_categories_path
      click_on('Passagens Aéreas')

      expect(page).to have_link('Editar', href: edit_product_category_path(ProductCategory.last))
    end

    it 'and enters edit page' do
      create(:product_category, name: 'Passagens Aéreas', code: 'PAX')

      visit product_categories_path
      click_on('Passagens Aéreas')
      click_on('Editar')

      expect(page).to have_current_path(edit_product_category_path(ProductCategory.last))
      expect(page).to have_field('Nome', with: 'Passagens Aéreas')
      expect(page).to have_field('Código', with: 'PAX')
    end

    it 'and updates product categories informations' do
      create(:product_category, name: 'Passagens Aéreas', code: 'PAX')

      visit product_categories_path
      click_on('Passagens Aéreas')
      click_on('Editar')
      fill_in 'Nome', with: 'Hospedagem Brasil'
      fill_in 'Código', with: ' HOSPBR'

      click_on 'Salvar'

      expect(page).to have_current_path(product_category_path(ProductCategory.last))
      expect(page).to have_content('Categoria atualizada com sucesso!')
      expect(page).to have_content('Hospedagem Brasil')
      expect(page).to have_content('HOSPBR')
    end
  end
end
