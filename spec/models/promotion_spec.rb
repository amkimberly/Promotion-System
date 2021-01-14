require 'rails_helper'

describe Promotion do
  context 'validation' do
    it 'attributes cannot be blank' do
      promotion = Promotion.new

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end

    it 'code must be unique' do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033')
      promotion = Promotion.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('deve ser único')
    end
  end
  context '#generate_coupons!' do
    it 'of a promotion with no coupons' do
    promotion = Promotion.create!(name: 'Páscoa', coupon_quantity: 5, 
                                  code: 'PASCOA21', discount_rate: 10, 
                                  expiration_date: 1.day.from_now)
    promotion.generate_coupons!

    expect(promotion.coupons.count).to eq(5)
    expect(promotion.coupons.map(&:code)).to contain_exactly('PASCOA21-0001',
                                                     'PASCOA21-0002',
                                                     'PASCOA21-0003',
                                                     'PASCOA21-0004',
                                                     'PASCOA21-0005')
    end
    it 'and coupons are already generated' do
      promotion = Promotion.create!(name: 'Páscoa', coupon_quantity: 5, 
                                    code: 'PASCOA21', discount_rate: 10, 
                                    expiration_date: 1.day.from_now)

      promotion.generate_coupons!

      expect {promotion.generate_coupons!}.to raise_error('Cupons já foram gerados')
      expect(promotion.coupons.count).to eq(5)
      expect(promotion.coupons.map(&:code)).to contain_exactly('PASCOA21-0001',
                                                       'PASCOA21-0002',
                                                       'PASCOA21-0003',
                                                       'PASCOA21-0004',
                                                       'PASCOA21-0005')
    end
  end
end
