require 'rails_helper'

feature 'Admin removes a promotion' do
  #ARRANGE
  let!(:promotion) {Promotion.create(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, 
                                    coupon_quantity: 100,
                                    expiration_date: '22/12/2033')}
  let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

  #ACTION
  before(:each) do
    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
  end

  scenario 'from home page' do
    #ASSERT
    expect(page).to have_link('Excluir', href: promotion_path(Promotion.last))
  end

  scenario "and goes to promotions' page" do
    #ACTION
    click_on 'Excluir'
    #ASSERT
    expect(current_path).to eq(promotions_path)
    expect(page).to have_content('Promoção removida com sucesso!')
    expect(page).to_not have_content('Natal')
  end
end