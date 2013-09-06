require 'spec_helper'

describe TrendReport do
  it {should respond_to :x_data}
  it {should respond_to :y_data}
  it {should respond_to :x_label}
  it {should respond_to :y_label}
  it {should respond_to :title}
  
  let(:report) {FactoryGirl.create(:trend_report)}

  describe "x_data" do
    it "is non nil" do
      report.x_data = nil
      report.should_not be_valid
    end

    it "should quack like an array" do
      report.x_data.is_a?(Array).should == true
    end
  end

  describe "y_data" do
    it "is non nil" do
      report.y_data = nil
      report.should_not be_valid
    end
    
    it "should quack like an array" do
      report.y_data.is_a?(Array).should == true
    end
  end

  describe "x_label" do
    it "is non nil" do
      report.x_label = nil
      report.should_not be_valid
    end
  end

  describe "y_label" do
    it "is non nil" do
      report.y_label = nil
      report.should_not be_valid
    end
  end

  describe "title" do
    it "is non nil" do
      report.title = nil
      report.should_not be_valid
    end
  end
end
