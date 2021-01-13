describe User do
  context 'validation' do
    it 'attributes cannot be blank' do
      user = User.new

      user.valid?

      expect(user.errors[:email]).to include('não pode ficar em branco')
      expect(user.errors[:password]).to include('não pode ficar em branco')
    end

    it 'attributes login with specific email adress only' do
      user = User.new

      user.valid?

      expect(user.errors[:email]).to include("precisa ser '@locaweb.com.br'")
    end
  end
end
