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
  
  
end
