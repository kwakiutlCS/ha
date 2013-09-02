FactoryGirl.define do
  sequence :title do |n|
    "title#{n}"
  end
  
  factory :category do
    
    title
    transaction_type false
    
  end
end
