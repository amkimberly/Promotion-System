class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: {active: 0, inactive: 10}
  
  def title
  "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end

  def as_json(options = {})
    super(options.merge(methods: %i[discount_rate expiration_date],
                        only: %i[]))
  end

  private

  def discount_rate
    promotion.discount_rate
  end

  def expiration_date
    I18n.l(promotion.expiration_date)
  end
end
