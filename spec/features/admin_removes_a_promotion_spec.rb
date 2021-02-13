require 'rails_helper'

describe 'Admin removes a promotion' do
  before do
    user = create(:user, email: 'piupiu@locaweb.com.br', password: '123456')
    login_as user
  end

  it 'from home page' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                      product_category_ids: 1, expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(page).to have_link('Excluir', href: promotion_path(Promotion.last))
  end

  it "and goes to promotions' page" do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 5,
                      product_category_ids: 1, expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Excluir'

    expect(page).to have_current_path(promotions_path)
    expect(page).to have_content('Promoção removida com sucesso!')
    expect(page).not_to have_content('Natal')
  end
end
