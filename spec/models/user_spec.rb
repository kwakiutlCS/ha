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

  describe "initial categories" do
    it "has 4 initial categories" do
      user.categories.count.should == 4
    end
    it "the first category is health" do
      user.categories.first.title.should == "Health"
    end
  end

  
end
