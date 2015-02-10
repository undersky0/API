FactoryGirl.define do
  factory :order, :class => 'Order' do
    state 0
    vat 20
    user_id 1
  end
end
