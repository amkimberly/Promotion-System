class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: {active: 0, cancel: 10, inactive:20}
  validates :order, presence: true, on: :coupon_inactivate

  def title
  "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end

  def as_json(options = {})
    super({methods: %i[discount_rate expiration_date],
          only: %i[]}.merge(options))
  end

  def inactivate!(order)
    self.order = order
    self.status = :inactive
    save!(context: :coupon_inactivate)
  end

  private

  def discount_rate
    promotion.discount_rate
  end

  def expiration_date
    I18n.l(promotion.expiration_date)
  end
end
