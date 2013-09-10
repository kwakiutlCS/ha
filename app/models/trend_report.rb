class TrendReport < ActiveRecord::Base
  attr_accessible :title, :x_data, :x_label, :y_data, :y_label

  validates :title, presence: true
  validates :y_label, presence: true
  validates :x_label, presence: true
  validates :y_data, presence: true
  validates :x_data, presence: true
  
  serialize :x_data
  serialize :y_data



  def self.getReport(user, options = {})
    data = user.transactions.where("date >= ?", (Date.today-1.year).beginning_of_month).group_by {|i| i.date.beginning_of_month}
    data.each do |k,v|
      data[k] = v.inject(0) {|sum, i| sum+i.value_cents/100.to_f}
    end
    
    report = TrendReport.new
    report.x_data = data.keys.sort
    report.y_data = []
    report.x_data.each_with_index do |i,index|
      report.y_data << [index+1,data[i].round(2)]
    end
    
    
    report
  end
end
