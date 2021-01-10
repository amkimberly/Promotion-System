require 'rails_helper'

feature 'User' do

  before(:each) do
    visit root_path
  end

  context 'Log in' do
    let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}
    
    scenario 'and receives welcome message' do

      click_on 'Login'
      fill_in 'Email', with: 'piupiu@locaweb.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('piupiu@locaweb.com.br')
      expect(page).to_not have_link('Login')
      expect(page).to have_link('Sair')
      expect(page).to_not have_link('Registrar conta')
    end
  end

  context 'Log out' do
    let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

    scenario 'and goes to home page' do

      click_on 'Login'
      fill_in 'Email', with: 'piupiu@locaweb.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
      click_on 'Sair'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Logout efetuado com sucesso!')
      expect(page).to_not have_content('piupiu@locaweb.com.br')
      expect(page).to have_link('Login')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'Create new account' do
    scenario 'successfully' do
      visit new_user_registration_path

      fill_in 'Email', with: 'piupiu@locaweb.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Conta criada com sucesso!")
    end

    scenario 'and fail' do
      visit new_user_registration_path

      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(current_path).to eq(user_registration_path)
      expect(page).to have_content("não pode ficar em branco")
    end
  end
end

