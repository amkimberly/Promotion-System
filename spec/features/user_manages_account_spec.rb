require 'rails_helper'

feature 'User' do

  before(:each) do
    visit root_path
  end

  context 'Log in' do
    let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

    scenario 'and receives welcome message' do

      fill_in 'Email', with: 'piupiu@locaweb.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('piupiu@locaweb.com.br')
      expect(page).to_not have_link('Login')
      expect(page).to have_link('sair')
      expect(page).to_not have_link('Registrar conta')
    end
  end

  context 'Log out' do
    let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

    scenario 'and goes to login page' do

      visit new_user_session_path
      fill_in 'Email', with: 'piupiu@locaweb.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
      click_on 'sair'

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
      expect(page).to_not have_content('piupiu@locaweb.com.br')
      expect(page).to have_button('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'Creates new account' do
    scenario 'successfully' do
      visit new_user_registration_path

      fill_in 'Email', with: 'piupiu@locaweb.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Conta criada com sucesso!")
    end

    scenario 'and shows blank error' do
      visit new_user_registration_path

      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(current_path).to eq(user_registration_path)
      expect(page).to have_content("não pode ficar em branco")
    end

    scenario "and shows email adress error" do

      visit new_user_registration_path

      fill_in 'Email', with: 'piupiu@locaweb.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(current_path).to eq(user_registration_path)
      expect(page).to have_content("precisa ser '@locaweb.com.br'")
    end
  end

  context 'Deletes account' do
    let!(:user) {User.create!(email: 'piupiu@locaweb.com.br', password: '123456')}

    scenario 'through profile page' do

      login_as user, scope: :user
      visit root_path

      expect(page).to have_link('Minha conta')
    end

    scenario 'successfully' do

      login_as user, scope: :user
      visit root_path
      click_on "Minha conta"
      click_on "Excluir minha conta"

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
      expect(page).to_not have_link("Excluir minha conta")
    end

  end
end

