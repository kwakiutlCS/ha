require 'spec_helper'

describe User do
  it {should respond_to(:name)}
  it {should respond_to(:email)}


  let(:user) {FactoryGirl.create(:user)}


  describe "#name" do
    it "is not nil" do
      user.name = nil
      user.should_not be_valid
    end

    it "is unique" do
      user.name = "palerma"
      user.save
      other = User.new(name: "palerma", email:"h@gh.pt", password: "password")
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
      user.email = "k@k.pt"
      user.save
      other = User.new(name: "palerma", email:"k@k.pt", password: "password")
      other.should_not be_valid
    end

    
  end

  
end
