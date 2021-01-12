require 'rails_helper'

feature 'Admin generates coupons' do
  let!(:user) { User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

  before(:each) do
    login_as user, scope: :user
  end

  scenario 'with coupon quantity available' do
    promotion = Promotion.create!(name: 'Páscoa', coupon_quantity: 5, 
                                 code: 'PASCOA21', discount_rate: 10, 
                                 expiration_date: 1.day.from_now)

    visit root_path
    click_on "Promoções"
    click_on promotion.name
    click_on 'Emitir cupons'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content("PASCOA21-0001")
    expect(page).to have_content("PASCOA21-0002")
    expect(page).to have_content("PASCOA21-0003")
    expect(page).to have_content("Cupons gerados com sucesso!")
    expect(page).not_to have_link('Emitir cupons')
  end
end
