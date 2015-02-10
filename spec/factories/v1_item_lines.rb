FactoryGirl.define do
  factory :item_line, :class => 'ItemLine' do
    quantity 1
    net_price 9
  end
  factory :line_with_order, :class => 'ItemLine' do |t|
    t.quantity {Faker::Number.digit}
    t.net_price {Faker::Commerce.price}
    t.association :order, :factory => :v1_order
  end
  
end
