FactoryGirl.define do
  factory :transaction do
    value_cents 759
    association :user, factory: :user
    association :category, factory: :category
    description "my descripri"
    date Date.today
  end


  
end
