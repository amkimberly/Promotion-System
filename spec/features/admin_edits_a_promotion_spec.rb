require 'rails_helper'

feature 'Admin edits a promotion' do
  scenario 'from promotions page' do

    #ARRANGE
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    #ACT
    visit promotions_path
    click_on "Natal"
   
    #ASSERT
    expect(page).to have_link('Editar', href: edit_promotion_path(Promotion.last))
  end


  scenario 'and enters edit page' do

    #ARRANGE
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')


    #ACT
    visit promotions_path
    click_on "Natal"
    click_on "Editar"

    #ASSERT
    expect(current_path).to eq(edit_promotion_path(Promotion.last))
    expect(page).to have_field('Nome', with: 'Natal')
    expect(page).to have_field('Descrição', with: 'Promoção de Natal')
    expect(page).to have_field('Código', with: 'NATAL10')
    expect(page).to have_field('Desconto', with: '10.0')
    expect(page).to have_field('Quantidade de cupons', with: '100')
    expect(page).to have_field('Data de término', with: '2033-12-22')
end
  scenario "and update promotion's informations" do

    #ARRANGE
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    #ACT
    visit promotions_path
    click_on "Natal"
    click_on "Editar"

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'

    click_on 'Salvar'

    #ASSERT
    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('90')
    expect(page).to have_content('22/12/2033')
  end
end