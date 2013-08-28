Given(/^the following users exist:$/) do |table|
  table.hashes.each do |a|
    FactoryGirl.create(:user, a)
  end
end
