FactoryBot.define do
  factory :promotion do
    sequence(:name) { |n| "promotion#{n}" }
    description { 'MyText' }
    code { 'promotion1' }
    discount_rate { 10 }
    coupon_quantity { 5 }
    expiration_date { 1.day.from_now }
    product_category_ids { nil }
  end
end
