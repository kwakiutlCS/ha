Given(/^the following categories exist:$/) do |table|
  table.hashes.each do |a|
    FactoryGirl.create(:category, a)
  end
end

Given(/^"(.*?)" has all the categories$/) do |arg1|
  user = User.where(name: arg1).first
  Category.all.each do |c|
    CategoryMap.create(category_id: c.id, user_id: user.id)
  end
end
