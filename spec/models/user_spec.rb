require 'spec_helper'

describe User do
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:categories)}


  let(:user) {FactoryGirl.create(:user)}


  describe "#name" do
    it "is not nil" do
      user.name = nil
      user.should_not be_valid
    end

    it "is unique" do
      other = FactoryGirl.build(:user, name: user.name)
      other.should_not be_valid
    end

    it "has a minimum size of 3" do
      user.name = "ze"
      user.should_not be_valid
    end

    it "has a maximum size of 15" do
      user.name = "qwertyuiopasdfgh"
      user.should_not be_valid
    end
  end

  describe "#email" do
    it "is not nil" do
      user.email = nil
      user.should_not be_valid
    end

    it "is unique" do
      other = FactoryGirl.build(:user, email: user.email)
      other.should_not be_valid
    end

    
  end

  describe "#addCategory" do
    it "creates a new category in the database if inexistent" do
      user.addCategory("car", "false")
      Category.last.title.should == "car"
    end

    it "adds a category to the user categories if inexistent" do
      user.addCategory("car", "false")
      c = Category.last
      user.categories.should include(c)
    end

    it "adds a category to the user categories if existent" do
      user.addCategory("car", "false")
      trengo = FactoryGirl.create(:user)
      trengo.addCategory("car", "false")
      c = Category.last
      trengo.categories.should include(c)
    end

    it "adds a category to the user categories if existent but differeent types" do
      user.addCategory("car", "false")
      trengo = FactoryGirl.create(:user)
      trengo.addCategory("car", "true")
      c = Category.last
      c.transaction_type.should == true
    end

    it "returns nil if user already has category" do
      user.addCategory("car", "false")
      c = user.addCategory("car", "false")
      user.categories.count.should == 1
    end
    it "adds category if user already has category but different transaction types" do
      user.addCategory("car", "false")
      c = user.addCategory("car", "true")
      user.categories.count.should == 2
    end
  end
  
  
  describe "#getExpenses" do
    before(:each) do
      user.addCategory("car","false")
      c1 = user.categories.last
      user.addCategory("food", "false")
      c2 = user.categories.last
      
      FactoryGirl.create(:transaction, user_id: user.id, category_id: c1.id, date: Date.today-2.year)
      FactoryGirl.create(:transaction, user_id: user.id, category_id: c2.id, date: Date.today-2.months)
      FactoryGirl.create(:transaction, user_id: user.id, category_id: c2.id, date: Date.today-2.weeks)
      FactoryGirl.create(:transaction, user_id: user.id, category_id: c1.id, date: Date.today-5.days)
      FactoryGirl.create(:transaction, user_id: user.id, category_id: c1.id, date: Date.today+2.days)
      FactoryGirl.create(:transaction, user_id: user.id, category_id: c1.id, date: Date.today)
      FactoryGirl.create(:transaction, user_id: user.id, category_id: nil, date: Date.today)
    end
    
    it "gets all the category with 'All'" do
      p = {filter_category: "All",date: "All"}
      c = user.getExpenses(p)
      c.count.should == 7
    end

    it "gets some of the filter_category" do
      p = {filter_category: "car",date: "All"}
      c = user.getExpenses(p)
      c.count.should == 4
    end

    it "gets the correct less than a year" do
      p = {filter_category: "All",date: "year"}
      c = user.getExpenses(p)
      c.count.should == 5
    end

    it "gets the correct less than a month" do
      p = {filter_category: "All",date: "month"}
      c = user.getExpenses(p)
      c.count.should == 3
    end

    it "gets the correct less than a week" do
      p = {filter_category: "All",date: "week"}
      c = user.getExpenses(p)
      c.count.should == 2
    end

    it "gets the correct less than a day" do
      p = {filter_category: "All",date: "day"}
      c = user.getExpenses(p)
      c.count.should == 2
    end

     it "gets the correct multiple conditions" do
      p = {filter_category: "car",date: "year"}
      c = user.getExpenses(p)
      c.count.should == 2
    end

    it "gets the correct with no category condition" do
      p = {filter_category: "No Category",date: "year"}
      c = user.getExpenses(p)
      c.count.should == 1
    end

    it "gets the correct with custom date" do
      p = {filter_category: "All",date: "custom", startDate: (Date.today-3.weeks).strftime("%B %d, %Y"), endDate: Date.today+2.weeks}
      c = user.getExpenses(p)
      c.count.should == 5
    end
  end
end
