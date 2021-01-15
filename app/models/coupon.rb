class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: {active: 0, inactive: 10}
  
  def title
  "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end
end
