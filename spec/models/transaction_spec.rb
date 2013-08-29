require 'spec_helper'

describe Transaction do
  it {should respond_to :value}
  it {should respond_to :user_id}
  it {should respond_to :category_id}
  it {should respond_to :description}
  it {should respond_to :date}


  let(:transaction) {FactoryGirl.create(:transaction)}

  describe "value" do

    it "has a non nil value" do
      transaction.value_cents = nil
      transaction.should_not be_valid
    end

    it "has a positive value" do
      transaction.value_cents = -2
      transaction.should_not be_valid
    end

  end

  it "has a non nil date" do
    transaction.date = nil
    transaction.should_not be_valid
  end

  describe "user" do
    it "has a non nil user" do
      transaction.user_id = nil
      transaction.should_not be_valid
    end

    it "is destroyed when user is destroyed" do
      n = transaction.user_id
      user = User.find(n)
      user.destroy
      Transaction.where(user_id: n).count.should == 0
    end
  end
  
  describe "description" do
    it "has a 255 characters limit" do
      transaction.description = "012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678012345678a"
      transaction.should_not be_valid
    end 
  end
end
