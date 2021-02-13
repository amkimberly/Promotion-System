require 'rails_helper'

describe ProductCategory do
  context 'when validates' do
    it 'attributes cannot be blank' do
      product_category = described_class.new

      product_category.valid?

      expect(product_category.errors[:name]).to include('não pode ficar em branco')
      expect(product_category.errors[:code]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      described_class.create!(name: 'Passagens Aéreas', code: 'PAX')
      product_category = described_class.new(code: 'PAX')

      product_category.valid?

      expect(product_category.errors[:code]).to include('deve ser único')
    end
  end
end
