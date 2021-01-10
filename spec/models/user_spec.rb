describe User do
  context 'validation' do
    it 'attributes cannot be blank' do
      user = User.new

      user.valid?

      expect(user.errors[:email]).to include('não pode ficar em branco')
      expect(user.errors[:password]).to include('não pode ficar em branco')


    end
  end
end
