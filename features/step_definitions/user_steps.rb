
Given(/^the following users exist:$/) do |table|
  table.hashes.each do |a|
    @user = FactoryGirl.create(:user, a)
  end
end

Given(/^I am signed in as "(.*?)"$/) do |arg1|
  
  steps %Q(Given I am on the homepage
     And I follow "Sign in"
     And I fill in "Name" with "#{arg1}"
     And I fill in "Password" with "password"
     And I press "Sign in"
     
    )
end
