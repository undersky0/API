FactoryGirl.define do
  factory :api_key, :class => 'ApiKey' do
    association :user
    #token "MyString"
  end

end
