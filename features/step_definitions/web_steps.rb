Given(/^I follow "(.*?)"$/) do |arg1|
  click_link arg1
end


Given(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

Given(/^I press "(.*?)"$/) do |arg1|
  click_button arg1
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content(arg1)
end


Then(/^I should not see "(.*?)"$/) do |arg1|
  page.should_not have_content(arg1)
end

Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I choose "(.*?)"$/) do |arg1|
  choose(arg1)
end
