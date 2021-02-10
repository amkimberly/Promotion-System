require 'rails_helper'
require 'bigdecimal'

describe 'Admin edits a promotion' do
  before do
    user = create(:user)
    login_as(user)

    category = create(:product_category)
    create(:promotion, name: 'Natal', description: 'Promoção de Natal', code: 'NATAL10',
                       discount_rate: 10, coupon_quantity: 100, product_category_ids: category.id,
                       expiration_date: '22/12/2033')
  end

  context 'when enters promotions page' do
    it 'and see edit link' do
      visit promotions_path
      click_on('Natal')

      expect(page).to have_link('Editar', href: edit_promotion_path(Promotion.last))
    end

    it 'and enters edit page' do
      visit promotions_path
      click_on('Natal')
      click_on('Editar')

      expect(page).to have_current_path(edit_promotion_path(Promotion.last))
      expect(page).to have_field('Título', with: 'Natal')
      expect(page).to have_field('Descrição', with: 'Promoção de Natal')
      expect(page).to have_field('Código', with: 'NATAL10')
      expect(page).to have_field('Desconto', with: '10.0')
      expect(page).to have_field('Quantidade de cupons', with: '100')
      expect(page).to have_field('Data de término', with: '2033-12-22')
    end

    it "and updates promotion's informations" do
      visit promotions_path
      click_on('Natal')
      click_on('Editar')
      fill_in 'Descrição', with: 'Promoção de Cyber Monday'
      click_on('Salvar')

      expect(page).to have_content('Promoção atualizada com sucesso!')
      expect(page).to have_content('Promoção de Cyber Monday')
    end
  end
end
