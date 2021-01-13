require 'rails_helper'

feature 'Visitor visit home page' do
  xscenario 'successfully' do
    visit root_path

    expect(page).to have_content('Login')
    expect(page).to have_content('Boas vindas ao sistema de gestão de '\
                                 'promoções')
  end
end
