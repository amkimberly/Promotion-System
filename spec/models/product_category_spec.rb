require 'rails_helper'

describe ProductCategory do
  context 'validation' do
    it 'attributes cannot be blank' do
      product_category = ProductCategory.new

      product_category.valid?

      expect(product_category.errors[:name]).to include('não pode ficar em branco')
      expect(product_category.errors[:code]).to include('não pode ficar em branco')
    
    end

    it 'code must be uniq' do
      ProductCategory.create!(name: 'Passagens Aéreas', code: 'PAX')
      product_category = ProductCategory.new(code: 'PAX')

      product_category.valid?

      expect(product_category.errors[:code]).to include('deve ser único')
    end
  end
end
