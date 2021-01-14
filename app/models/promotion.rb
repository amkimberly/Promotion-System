class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            presence: { message: 'não pode ficar em branco' }
  validates :code, uniqueness: { message: 'deve ser único' }

  #TODO: Gerar cupons faltantes. Admin alterou promotion e aumentou numero de cupons.
  # Deve gerar cupons restantes.
  def generate_coupons!
    raise 'Cupons já foram gerados' if coupons.any?
    coupon_codes = 
    (1..coupon_quantity).map do |number|
     {code: "#{code}-#{'%04d' % number}"}
    end
    coupons
    .create_with(created_at: Time.now, updated_at: Time.now)
    .insert_all!(coupon_codes)
  end
end
