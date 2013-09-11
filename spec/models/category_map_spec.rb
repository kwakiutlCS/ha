require 'spec_helper'

describe CategoryMap do
  it "has a unique user_id category_id pair" do
    CategoryMap.create(user_id: 3, category_id: 2)
    c = CategoryMap.new(user_id: 3, category_id: 2)
    c.should_not be_valid
  end

  it "is destroyed when category is destroyed" do
    c = FactoryGirl.create(:category)
    m = CategoryMap.create(user_id: 2, category_id: c.id)
    id = m.id
    c.destroy
    CategoryMap.where(id: id).count == 0
  end

  it "is destroyed when user is destroyed" do
    initial_categories = ["food", "health", "groceries", "utilities", "electricity"]
    initial_categories.each do |i|
      Category.create(title: i, transaction_type: false)
    end
    c = FactoryGirl.create(:user)
    
  
    m = CategoryMap.create(user_id: c.id, category_id: 3)
    id = m.id
    c.destroy
    CategoryMap.where(id: id).count == 0
  end
end
