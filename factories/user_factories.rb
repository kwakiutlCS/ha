FactoryGirl.define do
  
  sequence :name  do |n|
    "name#{n}" 
  end

  sequence :email do |n|
    "email#{n}@email.pt" 
  end

  factory :user do
    name
    email
    password "password"
    password_confirmation "password"
  end
end
