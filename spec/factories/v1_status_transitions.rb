FactoryGirl.define do
  factory :status_transition, :class => 'StatusTransition' do |t|
    t.event "MyString"
    t.from "MyString"
    t.to "MyString"
    t.association :order, :factory => :v1_order
  end

end
