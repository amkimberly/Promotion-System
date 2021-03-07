require 'rails_helper'

describe 'User' do
  before do
    visit root_path
  end

  context 'when Log in' do
    it 'and receives welcome message' do
      create(:user, email: 'piupiu@mail.com', password: '123456')

      fill_in 'Email', with: 'piupiu@mail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('piupiu@mail.com')
      expect(page).not_to have_link('Login')
      expect(page).to have_link('sair')
      expect(page).not_to have_link('Registrar conta')
    end
  end

  context 'when Log out' do
    it 'and goes to login page' do
      create(:user, email: 'piupiu@mail.com', password: '123456')

      visit new_user_session_path
      fill_in 'Email', with: 'piupiu@mail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
      click_on 'sair'

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
      expect(page).not_to have_content('piupiu@mail.com')
      expect(page).to have_button('Entrar')
      expect(page).not_to have_link('Sair')
    end
  end

  context 'when Creates new account' do
    it 'successfully' do
      visit new_user_registration_path
      fill_in 'Email', with: 'piupiu@mail.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Conta criada com sucesso!')
    end

    it 'and attributes cannot be blank' do
      visit new_user_registration_path

      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content('não pode ficar em branco')
    end

    it 'and shows email adress error' do
      visit new_user_registration_path

      fill_in 'Email', with: 'piupiu@locaweb.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação senha', with: '123456'
      click_on 'Registrar'

      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content('precisa ser @mail.com')
    end
  end

  context 'when Deletes account' do
    it 'and goes through profile page' do
      create(:user, email: 'piupiu@mail.com', password: '123456')

      visit new_user_session_path
      fill_in 'Email', with: 'piupiu@mail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
      visit root_path

      expect(page).to have_link('Minha conta')
    end

    it 'successfully' do
      user = create(:user, email: 'piupiu@mail.com', password: '123456')

      login_as user
      visit root_path
      click_on 'Minha conta'
      click_on 'Excluir minha conta'

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
      expect(page).not_to have_link('Excluir minha conta')
    end
  end
end
