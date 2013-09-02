require 'spec_helper'

describe Category do
  it {should respond_to :title}
  it {should respond_to :transaction_type}
  
  let(:palerma) {FactoryGirl.create(:user)}
  let(:trengo) {FactoryGirl.create(:user)}
  let(:category) {FactoryGirl.create(:category, title: "myTiTle", transaction_type: false)}
  
  describe "title" do
    it "has a non nil title" do
      category.title = nil
      category.should_not be_valid
    end

    it "has a non blank title" do
      category.title = ""
      category.should_not be_valid
    end

    it "has a unique title for a given transaction_type" do
      category.save
      other = FactoryGirl.build(:category, title: "mytitle", transaction_type: false)
      other.should_not be_valid
    end

    
    it "has an irrelevant title for different transaction_types" do
      category.save
      other = FactoryGirl.build(:category, title: "myTitle", transaction_type: true)
      other.should be_valid
    end
    
    
  end

  describe "transaction_type" do
    it "has a non nil transaction_type" do
      category.transaction_type = nil
      category.should_not be_valid
    end
  end


 
end
