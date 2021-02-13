require 'rails_helper'

describe 'Visitor visit home page' do
  xit 'successfully' do
    visit root_path

    expect(page).to have_content('Login')
    expect(page).to have_content('Boas vindas ao sistema de gestão de '\
                                 'promoções')
  end
end
