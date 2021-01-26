require 'rails_helper'
require 'bigdecimal'

feature 'Admin edits a promotion' do
  scenario 'from promotions page' do
    #ARRANGE
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                        product_category_ids: 1, expiration_date: '22/12/2033')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    #ACT
    login_as user, scope: :user
    visit promotions_path
    click_on "Natal"
   
    #ASSERT
    expect(page).to have_link('Editar', href: edit_promotion_path(Promotion.last))
  end


  scenario 'and enters edit page' do

    #ARRANGE
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                        product_category_ids: 1, expiration_date: '22/12/2033')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')



    #ACT
    login_as user, scope: :user
    visit promotions_path
    click_on "Natal"
    click_on "Editar"

    #ASSERT
    expect(current_path).to eq(edit_promotion_path(Promotion.last))
    expect(page).to have_field('Título', with: 'Natal')
    expect(page).to have_field('Descrição', with: 'Promoção de Natal')
    expect(page).to have_field('Código', with: 'NATAL10')
    expect(page).to have_field('Desconto', with: '10.0')
    expect(page).to have_field('Quantidade de cupons', with: '100')
    expect(page).to have_field('Data de término', with: '2033-12-22')
end
  scenario "and updates promotion's informations" do
    #ARRANGE
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                        product_category_ids: 1, expiration_date: '22/12/2033')
    user = User.create!(email: 'piupiu@locaweb.com.br', password: '123456')

    #ACT
    login_as user, scope: :user
    visit promotions_path
    click_on "Natal"
    click_on "Editar"

    fill_in 'Título', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'

    click_on 'Salvar'

    #ASSERT
    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content("Promoção atualizada com sucesso!")
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('90')
    expect(page).to have_content('22/12/2033')
  end
end