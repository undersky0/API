FactoryGirl.define do
  factory :user, :class => 'User' do
    name {Faker::Name.first_name}
  end

end
