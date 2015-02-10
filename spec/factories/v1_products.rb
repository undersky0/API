FactoryGirl.define do
  factory :product, :class => 'Product' do |t|
    t.name {Faker::Name.last_name}
    t.net_price "9.99"
  end
  factory :product_with_line, :class => 'Product' do |t|
    t.name {Faker::Name.last_name}
    t.net_price "9.98"
    t.association :item_line, :factory => :line_with_order
  end


end
