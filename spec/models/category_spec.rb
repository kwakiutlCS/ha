require 'spec_helper'

describe Category do
  it {should respond_to :title}
  it {should respond_to :user_id}
  it {should respond_to :transaction_type}
  
  let(:palerma) {FactoryGirl.create(:user)}
  let(:trengo) {FactoryGirl.create(:user)}
  let(:category) {FactoryGirl.create(:category, transaction_type: false)}
  
  describe "title" do
    it "has a non nil title" do
      category.title = nil
      category.should_not be_valid
    end

    it "has a non blank title" do
      category.title = ""
      category.should_not be_valid
    end

    it "has a unique title for a given user and transaction_type 1" do
      category = palerma.categories.build(title: "myTitle", transaction_type: false)
      category.save
      other = palerma.categories.build(title: "mytItLe", transaction_type: false)
      other.should_not be_valid
    end

    it "has a unique title for a given user and transaction_type 2" do
      category.title = "myTitle"
      category.user_id = palerma.id
      category.transaction_type = false
      category.save
      other = trengo.categories.build(title: "mytItLe", transaction_type: false)
      other.should be_valid
    end

    it "has a unique title for a given user and transaction_type 3" do
      category.title = "myTitle"
      category.user_id = palerma.id
      category.transaction_type = true
      category.save
      other = palerma.categories.build(title: "mytItLe", transaction_type: false)
      other.should be_valid
    end
    
    it "has a unique title for a given user and transaction_type 4" do
      category.title = "Title"
      category.user_id = palerma.id
      category.transaction_type = false
      category.save
      other = palerma.categories.build(title: "mytItLe", transaction_type: false)
      other.should be_valid
    end
  end

  describe "transaction_type" do
    it "has a non nil transaction_type" do
      category.transaction_type = nil
      category.should_not be_valid
    end
  end


  describe "user_id" do
    it "has a non nil user_id" do
      category.user_id = nil
      category.should_not be_valid
    end

    it "has a existing user" do
      other = palerma.categories.build(title: "mytItLe", transaction_type: false)
      other.save
      palerma.destroy
      Category.where(title: "Mytitle").count.should == 0
    end
  end
end
