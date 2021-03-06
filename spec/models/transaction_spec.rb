require 'spec_helper'

describe Transaction do
  it {should respond_to :value}
  it {should respond_to :user_id}
  it {should respond_to :category_id}
  it {should respond_to :description}
  it {should respond_to :date}
  it {should respond_to :transaction_type}
  before(:each) do
    initial_categories = ["food", "health", "groceries", "utilities", "electricity"]
    initial_categories.each do |i|
      Category.create(title: i, transaction_type: false)
    end
    
  end

  let(:transaction) {FactoryGirl.create(:transaction)}
  let(:user) {User.find(transaction.user_id)}

  it "has a non nil transaction_type" do
    transaction.transaction_type = nil
    transaction.should_not be_valid
  end


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

  describe "#value" do
    it "has a \d+\.\d\d format" do
      transaction.value_cents = 230
      transaction.value.should == "$2.30"
    end
    it "has a \d+\.\d\d format" do
      transaction.value_cents = 200
      transaction.value.should == "$2.00"
    end
    it "has a \d+\.\d\d format" do
      transaction.value_cents = 37
      transaction.value.should == "$0.37"
    end
    
  end


  describe "self.createTransaction" do
    describe "value" do
      it "accepts "" as 0" do
        hash ={"value" => "", "qty" => "4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "0"
      end

      it "has a limit of 999999999.99 units" do
        hash ={"value" => "1000000000.00", "qty" => "4"}
        result = Transaction.createTransaction(hash, user)
        result.should == nil
      end
    end

    it "has not a key 'value'" do
      hash ={"value" => "3", "qty" => "4"}
      result = Transaction.createTransaction(hash, user)
      result.should_not include("value")
    end

    it "has not a key 'category'" do
      hash ={"value" => "3", "qty" => "4", "category" => "Food"}
      result = Transaction.createTransaction(hash, user)
      result.should_not include("category")
    end

    it "has a key 'value_cents'" do
      hash ={"value" => "3", "qty" => "4"}
      result = Transaction.createTransaction(hash, user)
      result.should include("value_cents")
    end


    describe "category" do
      it "returns nil category_id for no category" do
        hash ={"value" => "0.33", "qty" => "4", "category" => nil}
        result = Transaction.createTransaction(hash, user)
        result["category_id"].should == nil
      end

      it "should return the correct category id" do
        c = user.categories.where(title: "groceries").first
        CategoryMap.create(user_id: user.id, category_id: c.id)
        hash ={"value" => "0.33", "qty" => "4", "category" => "groceries"}
        result = Transaction.createTransaction(hash, user)
        result["category_id"].should == c.id
      end

      
    end

    describe "conversion" do
      it "deals with \d+.\d\d format" do
        hash ={"value" => "0.33", "qty" => "4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "33"
      end 
      
       it "deals with .\d\d format" do
        hash ={"value"=>".33", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "33"
      end 

      it "deals with .\d format" do
        hash ={"value"=>".3", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "30"
      end 


      it "deals with \d+.\d format" do
        hash ={"value"=>"0,3", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "30"
      end 

      it "deals with \d+.\d\d format" do
        hash ={"value" => "0,33", "qty" => "4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "33"
      end 
      
       it "deals with .\d\d format" do
        hash ={"value"=>",33", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "33"
      end 

      it "deals with .\d format" do
        hash ={"value"=>",3", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "30"
      end 


      it "deals with \d+,\d format" do
        hash ={"value"=>"0,3", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "30"
      end 
      
      it "deals with \d+ format" do
        hash ={"value"=>"34", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "3400"
      end 

      it "deals with multiple . format" do
        hash ={"value"=>"34.0.2.5", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result.should == nil
      end 

      it "deals with multiple , format" do
        hash ={"value"=>"34,1,0", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result.should == nil
      end 

      it "deals with multiple ., format" do
        hash ={"value"=>"34.1,0", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result.should == nil
      end 

       it "deals with multiple ,. format" do
        hash ={"value"=>"34,1.0", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result.should == nil
      end 

      it "deals with large decimal places" do
        hash ={"value"=>"34.235684", "qty"=>"4"}
        result = Transaction.createTransaction(hash, user)
        result["value_cents"].should == "3423"
      end 

    end
  end

  describe "self.getTotal" do
    it "returns the sum of a collection of transactions" do
      Transaction.all.each do |t|
        t.destroy
      end
      t1 = FactoryGirl.create(:transaction, value_cents: "3425")
      t2 = FactoryGirl.create(:transaction, value_cents: "332")
      Transaction.getTotal(Transaction.all).should == "$37.57"
    end
  end
end
