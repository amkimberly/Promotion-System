require 'rails_helper'

describe Coupon do
  context 'title' do

    it 'status default' do
      coupon = Coupon.new(code: 'NATAL10-0001')
      expect(coupon.title).to eq('NATAL10-0001 (Disponível)')
    end

    it 'status inactive' do
      coupon = Coupon.new(code: 'NATAL10-0001', status: :inactive)
      expect(coupon.title).to eq('NATAL10-0001 (Desabilitado)')
    end
  end
end
