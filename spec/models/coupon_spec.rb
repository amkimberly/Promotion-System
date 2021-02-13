require 'rails_helper'

describe Coupon do
  context 'when title' do
    it 'status default' do
      coupon = described_class.new(code: 'NATAL10-0001')
      expect(coupon.title).to eq('NATAL10-0001 (Disponível)')
    end

    it 'status inactive' do
      coupon = described_class.new(code: 'NATAL10-0001', status: :cancel)
      expect(coupon.title).to eq('NATAL10-0001 (Desabilitado)')
    end
  end
end
